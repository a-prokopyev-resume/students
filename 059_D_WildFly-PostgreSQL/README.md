=============================== The Beginning of the Copyright Notice ================================   
 The AUTHOR of this file and the owner of all exclusive rights in this file is Alexander Borisovich Prokopyev   
 born on December 20, 1977 resident of the city of Kurgan, Russia;   
 Series and Russian passport number of the AUTHOR (only the last two digits for each one): **22-****91   
 Russian Individual Taxpayer Number of the AUTHOR (only the last four digits): ********2007   
 Russian Insurance Number of Individual Ledger Account of the AUTHOR (only the last five digits): ***-***-859 04   
 Copyright (C) Alexander B. Prokopyev, 2024, All Rights Reserved.   
 Contact of the AUTHOR: a.prokopyev.resume at gmail dot com   
 WWW: https://github.com/a-prokopyev-resume/students   

 All source code and other content contained in this file is protected by copyright law.   
 This file is licensed by the AUTHOR under AGPL v3 (GNU Affero General Public License): https://www.gnu.org/licenses/agpl-3.0.en.html   

 THIS FILE IS LICENSED ONLY PROVIDED FOLLOWING RESTRICTIONS ALSO APPLY:   
 Nobody except the AUTHOR may alter or remove this copyright notice from any copies of this file content (including modified fragments).   
 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an   
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    

 ATTENTION: If potential user's or licensee's country laws collide or are not compatible with the terms of this copyright notice or    
 if a potential user or licensee does not agree with the terms of this copyright notice then such potential user or licensee     
 is STRONGLY PROHIBITED to use this file by any method.   
===================================== The End of the Copyright Notice ================================   

### Описание скриптов:

# Скрипты рассчитаны для запуска на хосте Ubuntu 22.04 LTS

`start.sh` - скрипт для запуска установки `Ansible` из `deb` пакета и потом запуска `playbook`.

`compose.sh` - скрипт для управления `docker-compose` с передачей ему переменных среды из файлов в каталоге `env`. Скрипт поддерживает следующие опции:  
* `start` - запуск всех сервисов docker композиции  
* `stop` - остановка всех сервисов композиции
* `restart` - перезапуск всех сервисов и демонстрация их лога запуска
* `clean` - удаление данных ранее запущенных, но уже неиспользуемых контейнеров композиции
* `inspect` - получение информации обо всех контейнерах композиции
* `logs` - отображение логов всех контейнеров композиции

`docker-compose.yml` - декларативная спецификация композиции

`ansible.yml` - `Ansible playbook`, который выполняет следующие шаги:
* Устанавливает `docker` из deb пакета.
* Запускает `docker` daemon.
* Добавляет "on the fly" хосты `localhost` и `pg1` (`docker` контейнер) в динамический `Ansible inventory`. Это необходимо, что бы далее можно было ссылаться на эти хосты группой `all` при загрузке переменных из каталога `var` для этой группы.
* Загружает переменные из всех `yml` и `json`  файлов каталога `var`.
* Устанавливает на хост `localhost` следующие `deb` пакеты: `mc`, `joe`, `htop`, `net-tools`, `dstat`, `python3-psycopg2`. Это удобно при пересоздании хоста `localhost` с нуля с помощью `LXD`.
* Устанавливает `docker-compose` бинарником с Github.
* (Пере)запускает контейнеры композиции скриптом `compose.sh restart`.
* Создаёт пользователя PostgreSQL, указанного в файле `vars/user.yml`, подключаясь к СУБД с помощью суперпользователя, указанного в файле `vars/super.yml`.
* Устанавливает внутрь `docker` контейнера `pg1`  следующие `deb` пакеты: `mc`, `joe`, `htop`, `net-tools`. Это удобно для отладки контейнера при входе в него командой `docker exec -ti pg1 bash` .

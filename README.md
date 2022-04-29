# Solar Panel Stats

Check solar panel power generation by hour, week and month.


## Hardware
<img width="591" alt="image" src="https://user-images.githubusercontent.com/23729423/165990388-7e953a83-8658-41c3-ab7a-85c4c4bedf5e.png">

## Libraries
- ruby 2.7.4
- rails 7.0.2
- sqlite3 1.4
- httparty 0.20.0
- figaro 1.2
- whenever 1.0
- chartkick 4.1
- groupdate 6.1

## Setup

1. Clone this repository
```git clone https://github.com/gogvale/solar_panel_stats/```
2. Inside the project run:
```sh
$ rails db:setup
```
3. Modify `config/application.yml` with the following info:
```yml
development:
  solar_panel_address: <solar_panel_url>/status.html
  solar_panel_username: <username>
  solar_panel_password: <password>
```
4. Run the following command to add cronjobs:
```sh
$ whenever --update-crontab
```
5. If necessary, modify the crontab with `crontab -e` in order to enable `root` to run the rails app, mine is as following:
```crontab
# m h  dom mon dow   command
@reboot rbenv sudo /home/gogvale/solar_panel/bin/rails s -b 0.0.0.0 -p 80

# Begin Whenever generated tasks for: /home/gogvale/solar_panel/config/schedule.rb at: 2022-04-28 20:51:44 -0500
0,15,30,45 * * * * /bin/bash -l -c 'cd /home/gogvale/solar_panel && rbenv exec rails runner -e development '\''GetPowerGenerationJob.perform_now'\'''

# End Whenever generated tasks for: /home/gogvale/solar_panel/config/schedule.rb at: 2022-04-28 20:51:44 -0500
```
6. Debugging done with `postfix`, restart Raspberry for starting the server by the cronjob


## Screens

<figcaption>Dashboard</figcaption>

![image](https://user-images.githubusercontent.com/23729423/165990953-0d03d9d9-7f33-455e-b0c0-02e521d65c52.png)

<figcaption>Collected data</figcaption>

![telegram-cloud-photo-size-1-5141149710025861611-y](https://user-images.githubusercontent.com/23729423/165990874-044f07e0-bff4-409a-aaad-591c6f82f242.jpg)

<figcaption>Solar Panel Interface Stats</figcaption>

![telegram-cloud-photo-size-1-5141149710025861612-x](https://user-images.githubusercontent.com/23729423/165990478-376461b5-e932-4efa-a466-bddee290c1a3.jpg)


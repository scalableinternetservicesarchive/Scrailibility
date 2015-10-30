#Scrailability

## Project Description

This web application provides a social platform where people can potentially
find their gym partners. We will collect registered members' information such as
age, height, weight, schedule, location, preference, etc, and organize it into
data layers. We run a matching alogrithm that matches members together who share
high compatibility. Eventually, we recommend matching results to users.
Moreover, based on users feedback by marking as unlike or like, we will adjust
our parameters in our matching alogrithm to find more personalized matching. 

##Team Members

- Soomin Jeong ![Soomin
  Jeong](https://scontent-sjc2-1.xx.fbcdn.net/hprofile-xap1/v/t1.0-1/p160x160/10388635_10203705939316343_6753214294767401392_n.jpg?oh=89ebd2f3a466aefe3763f390dfa7de40&oe=568E3790)
- Siwen Wang ![Siwen
  Wang](https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xft1/v/t1.0-1/c0.0.160.160/p160x160/10348520_1382856965337806_4659452213453053569_n.jpg?oh=63465bed9686d86e8904a6bf89b8bccf&oe=56D07AE7&__gda__=1452426087_fb3cecf5b722a64d2d3ff798ac8823ad)
- Tom Tang ![Tom
  Tang](https://scontent-sjc2-1.xx.fbcdn.net/hprofile-xaf1/v/t1.0-1/p160x160/11987032_836059213176269_7713877708687893657_n.jpg?oh=f14282424bbd08000140156e5bf7dee7&oe=56997B27)
- Calvin Chan ![Calvin
  Chan](https://scontent-sjc2-1.xx.fbcdn.net/hprofile-xpt1/v/t1.0-1/p160x160/11667336_10207003459829585_9033733495530844598_n.jpg?oh=6d728d7722c7f45b44285bdc842f1cf4&oe=5690E5DD)

## MySQL Setup

1. Make sure MySQL is installed.
  * `brew install mysql`
  * `apt-get install mysql`
  * ...
2. Ensure that the Mysql daemon is running
  * `[sudo] mysqld`
  * (IF ON MAC) note the socket that mysqld is running on
    1. It should say something like `Version: '5.6.24'  socket:
      '/tmp/mysql.sock'  port: 3306  Homebrew`
  * Test by trying to connect via mysql shell `mysql -u root`
3. Open `/config/database.yml` and edit settings
  * Change the socket to what is noted in 2.b.i
  * If you want to run on another user other than `root`, change the username
    1. If the alternate user has a password, you will need to add that as
      well
    2. `password: **your user password here**`
4. `rake db:create`
5. `rake db:schema:load`

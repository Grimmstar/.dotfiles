# How To:
## Set Up A Postgres Database for Django
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

For the sake of being brief, this how-to assumes that Postgres is already installed and running.
See [this page](https://github.com/Grimm-Child/.Matrix/blob/main/wsl/scripts/read_me.md) for two possible ways to ensure Postgres is running at start up.

#### ⭐ Log in to the postgres shell
*Note* The password requested is your own password
```
sudo su - postgres
```

#### ⭐ Start the `psql` console
```
psql
```

#### ⭐ Create a user, grant `superuser` privledges to the new user
```
CREATE USER <username> WITH PASSWORD '<password>';
ALTER USER <username> WITH SUPERUSER;
```

#### ⭐ Create the database
```
CREATE DATABASE <db_name> OWNER <username>;
```

#### ⭐ Return to your normal shell
```
quit #returns you to the postgres shell
exit #returns you to your normal shell
```

Fill in the `settings` files and `.env` files with the variables created here.

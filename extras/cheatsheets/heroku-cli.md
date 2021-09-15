# 🟣 Heroku CLI Cheat Sheet
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

#### 🟣 Install
```
curl https://cli-assets.heroku.com/install.sh | sh
# - or -
npm install -g heroku
```

#### 🟣 Log in
```
heroku open
# - or -
heroku login
```

### 🟣 General Commands
```
heroku commands                # List all the commands
heroku help <command>          # Display help for Heroku commands
heroku notifications           # Display notifications
```

## 🟣 Apps
*Notes: The Heroku documentation doesn't really mention this, but you should probably add an `--app` flag for every command that is app-specific, example: `<command> -a <app_name>`.*
```
heroku apps                                         # List apps
heroku apps:create <app_name>                       # Create an app by name
heroku apps:destroy --app <app_name>                # Delete an app
heroku apps:info                                    # Get info on an app
heroku apps:open                                    # Open app in browser
heroku apps:rename -a <app_name> <new_app_name>     # Rename app
heroku apps:errors -a <app_name>                    # View app errors
_________
git push heroku master
```
#### Favorite Apps
```
heroku apps:favorites                           # List favorite apps
heroku apps:favorites:add -a <app_name>         # Add app to favorites
heroku apps:favorites:remove -a <app_name>      # Remove app from favorites
```
#### Config
```
heroku config                  # Display the config vars for an app
heroku config -s               # List in shell format
heroku config:get <key>...     # Display a single config value for an app
heroku config:set <key>        # Set one or more config vars
heroku config:edit <key>       # Interactively edit config vars
heroku config:unset <key>      # Unset one or more config vars
```
#### Buildpacks
```
heroku buildpacks                         # Display the buildpacks for an app
heroku buildpacks:search <term>           # Search for buildpacks
heroku buildpacks:info <buildpack>        # Display info about a biildpack
heroku buildpacks:versions <buildpack>    # List versions of a buildpack
heroku buildpacks:set <buildpack>         # Sets the buildpack
heroku buildpacks:add <buildpack>         # Add new app buildpack
heroku buildpacks:remove <buildpack>      # Remove a buildpack
heroku buildpacks:clear                   # Clear all buildpacks set on the app
```
#### Features
```
heroku features                         # List available app features
heroku features:enable <feature>        # Enables an app feature
heroku features:disable <feature>       # Disables an app feature
heroku features:info <feature>          # Display information about a feature
```
#### Add-ons
```
heroku addons                     # List installed add-ons
heroku addons --all               # List all add-ons
heroku addons -a <app_name>    # List add-ons for a specific app
```
```
heroku addons:info <addon_name>   # Show detailed add-on resource and attachment information
heroku addons:docs <addon_name>   # Open an add-on's documentation
heroku addons:open <addon_name>   # Open an add-on’s dashboard in the browser
heroku addons:wait <addon_name>   # Show provisioning status of the add-ons on the app
```
```
heroku addons:services            # List all available add-on services
heroku addons:plans <service>     # List available plans for an add-on service
```
```
# Note that `heroku addons:upgrade` and `heroku addons:downgrade` are the same.
heroku addons:upgrade <addon_name> <plan>
heroku addons:rename <addon_name> <new_name>
```
```
heroku addons:create <service>:<plan>
heroku addons:attach <addon_name>
heroku addons:detach <addon_name>
heroku addons:destroy <addon_name>
```
#### Labs
```
heroku labs                       # List experimental features
heroku labs:enable <feature>      # Enable an experimental feature
heroku labs:disable <feature>     # Disable an experimental feature
heroku labs:info <feature>        # Show info for an experimental feature
```
#### Releases
```
heroku releases
heroku releases:info v13
heroku rollback
```

## Logs
```
heroku logs                    # Display recent log output
heroku logs -t                 # Tail logs
heroku logs -s <app_name>      # View logs by source
```

## Dynos
```
heroku dyno:kill <dyno>        # Stop app dyno
heroku dyno:resize             # Manage dyno sizes
heroku dyno:restart <dyno>     # Restart app dynos
heroku dyno:stop <dyno>        # Stop app dyno
heroku dyno:scale              # Scale dyno quantity up or down
```

## Security
#### Certificates
```
heroku certs                       # List SSL certificates for an app
heroku certs:info                  # Show certificate information for an SSL certificate
heroku certs:generate <domain>     # Generate a key and a CSR or self-signed certificate
heroku certs:key                   # Print the correct key for the given certificate
heroku certs:add <cert_key>        # Add an SSL certificate to an app
heroku certs:update <cert_key>     # Update an SSL certificate on an app
heroku certs:auto                  # Show ACM status for an app
heroku certs:auto:enable           # Enable ACM status for an app
heroku certs:auto:refresh          # Refresh ACM for an app
heroku certs:auto:disable          # Disable ACM for an app
heroku certs:chain                 # Print an ordered & complete chain for a certificate
heroku certs:remove                # Remove an SSL certificate from an app
```
#### Keys
```
heroku keys                  # Display your SSH keys
heroku keys:add <key>        # Add a SSH key
heroku keys:remove <key>     # Remove a SSH key
heroku keys:clear            # Remove all keys
```

#### auth:2fa
```
heroku auth:2fa            # Check 2fa status
heroku auth:2fa:disable    # Disable 2fa
heroku auth:login          # Login with your Heroku credentials
heroku auth:logout         # Clears local login credentials and invalidates API session
```
```
heroku auth:token          # Outputs current CLI authentication token
heroku auth:whoami         # Display the current logged in user
```

#### OAuth
```
heroku authorizations                         # List OAuth authorizations
heroku authorizations:create                  # Create a new OAuth authorization
heroku authorizations:info <id>               # Show an existing OAuth authorization
heroku authorizations:revoke <id>             # Revoke OAuth authorization
heroku authorizations:rotate <id>             # Updates an OAuth authorization token
heroku authorizations:update <id>             # Updates an OAuth authorization
```
```
heroku clients                                # List your OAuth clients
heroku clients:create <name> <redirect_uri>   # Create a new OAuth client
heroku clients:destroy <id>                   # Delete client by ID
heroku clients:info <id>                      # Show details of an oauth client
heroku clients:update <id>                    # Update OAuth client
heroku clients:rotate <id>                    # Rotate OAuth client secret
```

## Postgres
#### Database
```
heroku addons:add heroku-postgresql                 # Add a database
heroku pg <db_name>                                 # Show database information
heroku pg:info <db_name>                            # Show database information
heroku pg:psql  <db_name>                           # Open a psql shell to the database
heroku pg:links <db_name>                           # Lists all databases and information on link
heroku pg:promote <db_name>                         # Sets DATABASE as your DATABASE_URL
```
##### Security
```
heroku pg:credentials <db_name>                     # Show information on credentials in the database
heroku pg:credentials:create <db_name>              # Create credential within database
heroku pg:credentials:destroy <db_name>             # Destroy credential within database
heroku pg:credentials:repair-default <db_name>      # Repair the permissions of the default credential within database
heroku pg:credentials:rotate <db_name>              # Rotate the database credentials
heroku pg:credentials:url <db_name>                 # Show information on a database credential
```
##### Data
```
heroku pg:bloat <db_name>                           # Show table and index bloat in your database ordered by most wasteful
heroku pg:blocking <db_name>                        # Display queries holding locks other queries are waiting to be released
heroku pg:connection-pooling:attach <db_name>       # Add an attachment to a database using connection pooling
heroku pg:copy <source> <target>                    # Copy all data from source db to target
heroku pg:pull <source> <target>                    # Pull Heroku database into local or remote database
heroku pg:push <source> <target>                    # Push local or remote into Heroku database
heroku pg:kill PID <db_name>                        # Kill a query
heroku pg:killall <db_name>                         # Terminates all connections for all credentials
heroku pg:links:create <remote> <db_name>           # Create a link between data stores
heroku pg:links:destroy <db_name> <link>            # Destroys a link between data stores
heroku pg:reset <db_name>                           # Delete all data in DATABASE
```
##### Backups
```
heroku pg:backups                                   # List database backups
heroku pg:backups:capture <db_name>                 # Capture a new backup
heroku pg:backups:cancel <backup_id>                # Cancel an in-progress backup or restore (default newest)
heroku pg:backups:download <backup_id>              # Downloads database backup
heroku pg:backups:restore <backup_id> <db_name>     # Restore a backup (default latest) to a database
heroku pg:backups:delete <backup_id>                # Delete a backup
```
##### Schedule
```
heroku addons:add pgbackups:auto-month              # Set monthly backups
heroku pg:backups:schedule <db_name>                # Schedule daily backups for given database
heroku pg:backups:unschedule <db_name>              # Stop daily backups
heroku pg:backups:schedules                         # List backup schedule
```
##### Info
```
heroku pg:settings <db_name>                        # Show your current database settings
heroku pg:backups:info <backup_id>                  # Get information about a specific backup
heroku pg:backups:url <backup_id>                   # Get secret but publicly accessible URL of a backup
heroku pg:outliers <db_name>                        # Show 10 queries that have longest execution time in aggregate
heroku pg:ps <db_name>                              # View active queries with execution time
```
##### Maintenance
```
heroku pg:maintenance <db_name>                     # Show current maintenance information
heroku pg:maintenance:run <db_name>                 # Start maintenance
heroku pg:maintenance:window <db_name> <window>     # Set weekly maintenance window
```
##### Troubleshoot
```
heroku pg:diagnose <db_name | report_id>            # Run or view diagnostics report
heroku pg:locks <db_name>                           # Display queries with active locks
```

## Local
```
heroku local <process_name>      # Run Heroku app locally
heroku local:run                 # Run a one-off command
heroku local:version             # Display node-foreman version
```

## Containers
```
heroku container             # Use containers to build and deploy Heroku apps
heroku container:login       # Log in to Heroku Container Registry
heroku container:logout      # Log out from Heroku Container Registry
heroku container:pull        # Pulls an image from an app’s process type
heroku container:push        # Builds, then pushes Docker images to deploy your Heroku app
heroku container:release     # Releases previously pushed Docker images to your Heroku app
heroku container:rm          # Remove the process type from the app
heroku container:run         # Builds, then runs the Docker image locally
```
#### Stacks
```
heroku apps:stacks -a <app_name>                  # Show a list of available stacks
heroku apps:stacks:set <stack> -a <app_name>      # Set the stack of an app
```

## Collaborate
```
heroku apps:join              # Join a team app
heroku apps:leave             # Leave a team app
heroku apps:lock              # Prevent team members from joining an app
heroku apps:unlock            # Unlock an app so any team member can join
heroku apps:open <path>       # Open an app in the web browser
```
```
heroku members                   # List members of a team
heroku members:add <email>       # Add a user to a team
heroku members:remove <email>    # Remove a user from a team
heroku members:set <email>       # Sets a members role in a team
```
```
heroku orgs             # List the teams that you are a member of
heroku orgs:open        # Open the team interface in a browser window
```
```
heroku apps:transfer <new_owner>           # Transfer ownership of an app
```

## Domains
```
heroku domains                           # List domains for an app
heroku domains:add <example.com>         # Add a domain to an app
heroku domains:add <www.example.com>     # Add another domain version to an app
_________
heroku domains:clear                     # Remove all domains from an app
heroku domains:remove <example.com>      # Remove a domain from an app
_________
heroku domains:info <hostname>           # Show detailed information for a domain on an app
heroku addons:add wildcard_domains
*.yourdomain.com => heroku.com
heroku domains:wait <hostname>           # Wait for domain to be active for an app
_________
heroku domains:update <hostname>         # Update a domain to use a different SSL certificate on an app

```

## Maintenance
```
heroku maintenance            # Display the current maintenance status of app
heroku maintenance:on         # Turn maintenance mode 'on' for an app
heroku maintenance:off        # Turn maintenance mode 'off' for an app

```
#### Running tasks
```
heroku run bash
heroku run console                  # Rails console
heroku run rake assets:precompile
```
####  Processes
```
heroku ps              # list
heroku ps:scale web=1  # spawn more dynos
```
#### Drains
```
heroku drains                            # Display the log drains of an ap
heroku drains:add <url>                  # Adds a log drain to an app
heroku drains:remove <url | token>       # Removes a log drain from an app
```

## CI
```
heroku ci                      # Display the most recent CI runs for the given pipeline
heroku ci:open                 # Open the Dashboard version of Heroku CI
heroku ci:config               # Display CI config vars
heroku ci:config:get <key>     # Get a CI config var
heroku ci:config:set           # Set CI config vars
heroku ci:config:unset         # Unset CI config vars
heroku ci:debug                # Opens an interactive test debugging session with the contents of the current directory
heroku ci:info <test>          # Show the status of a specific test run
heroku ci:last                 # Shows the output of the most recent run
heroku ci:migrate-manifest     # app-ci.json is deprecated. Run this command to migrate to app.json with an environments key.
heroku ci:run                  # Run tests against current directory
heroku ci:rerun <number>       # Rerun tests against current directory
```

#### Autocomplete
```
heroku autocomplete <shell>        # display autocomplete installation instructions
```

## Git
```
heroku git:clone <directory>        # Clones a Heroku app to the local machine
heroku git:remote                   # Adds a git remote to an app repo

```

#### Restart
```
heroku restart
```

#### htpasswd (for PHP apps)
```
# Create an .htaccess file in the webroot:
AuthUserFile /app/www/.htpasswd
AuthType Basic
AuthName "Restricted Access"
Require valid-user
_________
# Create a .htpasswd file:
$ htpasswd -c .htpasswd <username>
```

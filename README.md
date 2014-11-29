darwin-calendar-server Cookbook
===============================
This cookbook can be used to setup and deploy instances of Darwin Calendar
Server on Amazon's OpsWorks platform.

Requirements
------------

#### cookbooks
- `apt` - Darwin Calendar Server has many dependencies.
- `simple_s3fs` - needed to mount an S3 bucket for shared attachments.
- `simple_iptables` - used to redirect HTTPS traffic on port 443 to alt-HTTPS port 8443.

#### services
* PostgreSQL database
* Memcached server
* Amazon S3 bucket
  
I recommend you just use Amazon RDS and Elasticache for the PostgreSQL and
Memcached servers. Darwin Calendar Server stores attachments on disk and not
in DB so this cookbook depends on simple_s3fs::setup to mount an Amazon S3 bucket
as a shared disk. It is assumed that you have already installed the DCS database
schema into your PostgreSQL database.

Usage
-----
1.  Install cookbooks darwin-calendar-server, simple_s3fs and simple_iptables to your OpsWorks cookbook repository.
2.  Add recipe darwin-calendar-server::setup to the setup lifecycle event of your layer.
3.  Update the "Custom Chef JSON" of your stack to include the following configuration structure:

```json
{
  "s3fs" : {
    "bucket" : "darwin-attach-bucket",
    "access_key_id" : "XXXXXXXXXXX",
    "secret_access_key" : "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
    "mount_point" : "/mnt/s3"
  },
  "postgres" : {
    "host" : "darwin-db.abcdef01234.us-west-2.rds.amazonaws.com",
    "database" : "darwin-db",
    "user" : "darwin-user",
    "password" : "darwin-password"
  },
  "memcached" : {
    "host" : "darwin-cache.abcd0123.cfg.usw2.cache.amazonaws.com",
    "port" : "11211"
  }
}
```

License
---------------------

Copyright 2013 Rhodey Orbits

Licensed under the GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
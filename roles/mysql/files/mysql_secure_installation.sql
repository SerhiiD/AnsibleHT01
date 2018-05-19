-- remove_anonymous_users
-- DELETE FROM mysql.user WHERE User='';

-- remove_remote_root
-- DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');

-- Removing privileges on test database
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';

-- reload_privilege_tables
FLUSH PRIVILEGES;

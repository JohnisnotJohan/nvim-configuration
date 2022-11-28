-- settings don't take effect. The real one is at ~/.config/sqls/config.yml
return {
    filetypes = { "sql", "mysql", "pgsql" },
    settings = {
        sqls = {
            connections = {
                -- { driver = 'mysql', dataSourceName = 'root:root@tcp(127.0.0.1:13306)/world' },
                {
                    driver = 'postgresql',
                    dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=root dbname=postgres sslmode=disable',
                },
            },
        },
    },
}

{
    env => {
        DEPLOY_ENV => 'development',
    },

    connections => {
        ssh => {
            type => 'SSH',
            user => $ENV{TEST_USER},
            password => $ENV{TEST_PASS},
        },
    },

    hosts => {
        "127.0.0.1" => {
            connection => 'ssh',
        },
    },

    deployment => {
        beercracker => [
            Shell => { script => 't/deploy.sh' },
        ],
    },

    deploy => {
        beercracker => [ "127.0.0.1" ],
    },
};

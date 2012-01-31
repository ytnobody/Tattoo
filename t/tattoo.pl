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
            'Clone::Git' => { repository => 'git://github.com/ytnobody/Tattoo.git' },
            'Dependency::CPANM' => { verbose => 1 },
            'Shell' => { script => 't/deploy.sh' },
        ],
    },

    deploy => {
        beercracker => [ "127.0.0.1" ],
    },
};

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
        firecracker => [
            'Clone::Git' => { repository => 'git://github.com/ytnobody/firecracker.git' },
            'Dependency::CPANM' => { verbose => 0 },
            'BootUp::Starlet' => { port => 19999, host => '0.0.0.0', max_workers => 3 },
        ],
    },

    deploy => {
        firecracker => [ "127.0.0.1" ],
    },
};

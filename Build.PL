use strict;
use warnings FATAL => 'all';
use Module::Build;


my @sdl_conf = split(/ /,`sdl2-config --libs`);
chomp(@sdl_conf);

my $builder = Module::Build->new(
	module_name    => 'FartD',
   	license        => 'perl',
   	dist_author    => ['Michael Hollenbeck'],
   	needs_compiler => 1,
   	configure_requires => {
   		'Config::AutoConf'   => '0.14',
   		'ExtUtils::CBuilder' => '0.27',
   		'ExtUtils::LibBuilder' => '0.01',
   		'Module::Build'      => '0.3603',
   	},
	requires=>{YAML=>0},
	dist_version_from=>"lib/FartD.pm",
	dist_abstract_from=>"lib/FartD.pm",
	libdir   => "./lib",
    extra_compiler_flags => '-I/usr/local/include', 
	extra_linker_flags=>[@sdl_conf],
	config=>{cc => 'gcc', ld => 'gcc'},
    include_dirs => ['src'],
    c_source     => [qw(src)],
	script_files=>["scripts/fartd"],
	install_path=>{system=>"/etc/systemd/system",conf=>"/etc/fartd",share=>"/usr/share/fartd"},
	share_files =>{map {($_=>$_)} glob("share/*.*") },
	conf_files=>{"conf/fartd.conf"=>"conf/fartd.conf"},
	system_files=>{"system/fartd.service"=>"system/fartd.service"},
);

$builder->add_build_element("share");
$builder->add_build_element("system");
$builder->add_build_element("conf");

$builder->create_build_script();


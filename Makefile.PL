use 5.008005;
use ExtUtils::MakeMaker 7.12; # for XSMULTI option


WriteMakefile(
  NAME           => 'FartD',
  VERSION_FROM   => 'lib/FartD.pm',
  PREREQ_PM      => {
	'Proc::Daemon'=>0,
	'File::Util'=>0,
	'YAML'=>0,
  },
  ABSTRACT_FROM  => 'lib/FartD.pm',
  AUTHOR         => 'Fatty Crabcakes',
  CCFLAGS        => '-fPIC -Doff64_t=__off64_t -pthread',
  LIBS			=> `sdl2-config --libs`,
  OPTIMIZE       => '-O3',
  LICENSE        => 'SSF',
  XSMULTI        => 1,
  TYPEMAPS		=>["lib/typemap"],
  "EXE_FILES"	=>["scripts/fartd"],
  dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);

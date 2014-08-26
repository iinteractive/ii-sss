requires "Catalyst::Controller" => "0";
requires "DateTime" => "0";
requires "DateTime::Duration" => "0";
requires "Digest::HMAC" => "0";
requires "Digest::SHA1" => "0";
requires "JSON" => "0";
requires "Moose" => "0";
requires "Moose::Role" => "0";
requires "MooseX::Params::Validate" => "0";

on 'test' => sub {
  requires "Catalyst" => "0";
  requires "Catalyst::Test" => "0";
  requires "FindBin" => "0";
  requires "Test::Exception" => "0";
  requires "Test::Moose" => "0";
  requires "Test::More" => "0";
  requires "lib" => "0";
  requires "strict" => "0";
  requires "warnings" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "6.30";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
};

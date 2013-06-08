#!/usr/bin/perl
BEGIN { use_ok( 'Some::Module' ); }
require_ok('Some::Module' );

# Various ways to say "ok"
ok($got eq $expected, $test_name);
isnt($got, %expected, $test_name);

# Rather than print STDERR " here's what went wrong\n"
diag("here's what went wrong");
  like  ($got, qr/expected/, $test_name);
  unlike($got, qr/expected/, $test_name);
  cmp_ok($got, '==', $expected, $test_name);
  is_deeply($got_complex_structure, $expected_complex_structure, $test_name);
  SKIP: {
      skip $why, $how_many unless $have_some_feature;
      ok( foo(),       $test_name );
      is( foo(42), 23, $test_name );
  };
  TODO: {
      local $TODO = $why;
      ok( foo(),       $test_name );
      is( foo(42), 23, $test_name );
  };
  can_ok($module, @methods);
  isa_ok($object, $class);
  pass($test_name);
  fail($test_name);
  BAIL_OUT($why);
  # UNIMPLEMENTED!!!
  my @status = Test::More::status;

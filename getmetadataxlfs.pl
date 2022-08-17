#!/usr/bin/perl

#s3ls.pl | grep "s3://s3-fremantle-uk-or-1/fremantleuk/DMS UK/Media Files/B/BlessThisHouse/" | grep -v FAST | grep xl | sort

@cpcommands = ();

print("\n  ~~Give Me your AWS Path: ");
chomp ($aws = <STDIN>);
print("\n");


$lscmd = "s3ls.pl | grep \"$aws\" | grep -v FAST | grep xl | sort";
#$aws = "\"$aws\"";
#print("\n$lscmd\n\n");

unless (open CMD, "$lscmd |")
{
  print("  ~~Cannot run $lscmd\n");
  exit(1);
}

while(<CMD>)
{
  chomp;
  #print("$_\n");
  $xlf   = "\"$_\"";
  $cpcmd = "aws s3 cp $xlf .";

  push(@cpcommands,$cpcmd);

}
close(CMD);

foreach $cpcmd (@cpcommands)
{
  unless (open CMD,"$cpcmd |")
  {
    print("Cannot run $cpcmd\n");
    exit(1);
  }

  while(<CMD>)
  {
    chomp;
    print("$_\n");
  }
  close(CMD);
}
print("\n");

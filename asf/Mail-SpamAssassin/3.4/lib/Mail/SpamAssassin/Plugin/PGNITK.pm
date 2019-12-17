package Mail::SpamAssassin::Plugin::PGNITK;

use strict;
use warnings;
use bytes;
use re 'taint';

use Digest::SHA qw(sha1 sha1_hex);

use Mail::SpamAssassin::Plugin;
use Mail::SpamAssassin::PerMsgStatus;
use Mail::SpamAssassin::Logger;

our @ISA = qw(Mail::SpamAssassin::Plugin);

sub new {
        my $class = shift;
        my ($main) = @_;

        $class = ref($class) || $class;
        my $self = $class->SUPER::new($main);
        bless ($self, $class);

        $self->{main} = $main;
        $self->{conf} = $main->{conf};
        $self->{use_ignores} = 1;

        $self->register_eval_rule("pgnitk");
        return $self;
}

sub pgnitk {
        my ($self, $pms) = @_;
        my $subject = $pms->get('Subject');
        $pms->set_tag ("PGNITK_TAG", "Checking PGNITK integration");
        $subject = lc $subject;
        my $tempstr = "Pgnitk " . $subject;
        dbg($tempstr);
        if($subject =~ m/prakriti/)
        {
                return 0;}

        return 1;
}



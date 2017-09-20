# ABSTRACT: Determine the responsible for tests via CHANGES file for upload to elasticsearch
# PODNAME: App::Prove::Elasticsearch::Blamer::Default

package App::Prove::Elasticsearch::Blamer::Default;

use strict;
use warnings;
use utf8;

use File::Basename qw{dirname};
use Cwd qw{abs_path};

=head1 SUBROUTINES

=head2 get_responsible_party

Get the responsible party from CHANGES

=cut

sub get_responsible_party {
    my $loc = abs_path(dirname(shift)."/../CHANGES");
    my $ret;
    open(my $fh, '<', $loc) or die "Could not open $loc";
    while (<$fh>) {
        ($ret) = $_ =~ m/\s*\w*\s*(\w*)$/;
        last if $ret;
    }
    close $fh;
    die 'Could not determine the latest version from CHANGES!' unless $ret;
    return $ret;
}

1;

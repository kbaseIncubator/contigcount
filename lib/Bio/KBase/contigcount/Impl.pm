package Bio::KBase::contigcount::Impl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = "0.1.0";

=head1 NAME

contigcount

=head1 DESCRIPTION

A KBase module: contigcount

This sample module contains one small method - count_contigs.

=cut

#BEGIN_HEADER
use Bio::KBase::workspace::Client;

#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 count_contigs

  $return = $obj->count_contigs($contigset_id)

=over 4

=item Parameter and return types

=begin html

<pre>
$contigset_id is a contigcount.contigset_id
$return is an UnspecifiedObject, which can hold any non-null object
contigset_id is a string

</pre>

=end html

=begin text

$contigset_id is a contigcount.contigset_id
$return is an UnspecifiedObject, which can hold any non-null object
contigset_id is a string


=end text



=item Description

Count contigs in a ContigSet

contigset_id - the ContigSet to count.

=back

=cut

sub count_contigs
{
    my $self = shift;
    my($contigset_id) = @_;

    my @_bad_arguments;
    (!ref($contigset_id)) or push(@_bad_arguments, "Invalid type for argument \"contigset_id\" (value was \"$contigset_id\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to count_contigs:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'count_contigs');
    }

    my $ctx = $Bio::KBase::contigcount::Server::CallContext;
    my($return);
    #BEGIN count_contigs
    my $wshandle=Bio::KBase::workspace::Client->new('https://kbase.us/services/ws');
    my $wsname='KBasePublicGenomesV5';
    my $wsobj=$wshandle->get_objects([{workspace=>$wsname,name=>$contigset_id}]);
    my $contigcount=scalar (@{$wsobj->[0]{data}{contigs}});
    
    $return = { 'params' => $contigset_id, 'contig_count' => $contigcount };
    #END count_contigs
    my @_bad_returns;
    (defined $return) or push(@_bad_returns, "Invalid type for return variable \"return\" (value was \"$return\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to count_contigs:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'count_contigs');
    }
    return($return);
}




=head2 version 

  $return = $obj->version()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module version. This is a Semantic Versioning number.

=back

=cut

sub version {
    return $VERSION;
}

=head1 TYPES



=head2 contigset_id

=over 4



=item Description

A string representing a ContigSet id.


=item Definition

=begin html

<pre>
a string
</pre>

=end html

=begin text

a string

=end text

=back



=cut

1;

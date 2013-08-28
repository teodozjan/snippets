# Install cpan module
perl -MCPAN -Mlocal::lib -e 'CPAN::install(XML::Parser::Lite)'

# More than grep
perl -nlwe 'print for /(...)/' config.xml

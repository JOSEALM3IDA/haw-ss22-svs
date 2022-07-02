DIR="/home/otto/tls"
DIR_ROOT="/home/otto/tls/root"
DIR_INTR="/home/otto/tls/intermediate"
DIR_INTR_USERS="/home/otto/tls/intermediate-user"

openssl ca -config $DIR_ROOT/root.conf -gencrl -out $DIR_ROOT/root.crl
openssl ca -config $DIR_INTR/intermediate.conf -gencrl -out $DIR_INTR/intermediate.crl
openssl ca -config $DIR_INTR_USERS/intermediate-user.conf -gencrl -out $DIR_INTR_USERS/intermediate-user.crl

docker cp $DIR_ROOT/root.crl svs:/userdata/webportal/root.crl
docker cp $DIR_INTR/intermediate.crl svs:/userdata/webportal/intermediate.crl
docker cp $DIR_INTR_USERS/intermediate-user.crl svs:/userdata/webportal/intermediate-user.crl

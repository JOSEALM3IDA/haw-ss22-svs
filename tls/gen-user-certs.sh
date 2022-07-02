DIR="/home/otto/tls"
DIR_ROOT="/home/otto/tls/root"
DIR_INTR="/home/otto/tls/intermediate-user"
DIR_USERS="/home/otto/tls/users"

rm -f $DIR_INTR/index $DIR_INTR/index.attr $DIR_INTR/serial $DIR_INTR/intermediate-user.csr
touch $DIR_INTR/index
echo 00 > $DIR_INTR/serial

openssl req -new -key $DIR_INTR/intermediate-user.key -out $DIR_INTR/intermediate-user.csr -config $DIR_INTR/intermediate-user_req.conf
openssl ca -in $DIR_INTR/intermediate-user.csr -out $DIR_INTR/intermediate-user.pem -config $DIR_ROOT/root.conf -extfile $DIR_ROOT/root.ext -days 730

cat $DIR_INTR/intermediate-user.pem $DIR_ROOT/root.pem > $DIR/svs23-user.pem

openssl req -new -key $DIR_USERS/ruben.key -out $DIR_USERS/ruben.csr -config $DIR_USERS/ruben_req.conf
openssl req -new -key $DIR_USERS/jose.key -out $DIR_USERS/jose.csr -config $DIR_USERS/jose_req.conf

openssl ca -in $DIR_USERS/ruben.csr -out $DIR_USERS/ruben.pem -config $DIR_INTR/intermediate-user.conf -extfile $DIR_INTR/intermediate-user.ext -days 365
openssl ca -in $DIR_USERS/jose.csr -out $DIR_USERS/jose.pem -config $DIR_INTR/intermediate-user.conf -extfile $DIR_INTR/intermediate-user.ext -days 365

openssl x509 -outform der -in $DIR_USERS/ruben.pem -out $DIR_USERS/ruben.crt
openssl x509 -outform der -in $DIR_USERS/jose.pem -out $DIR_USERS/jose.crt

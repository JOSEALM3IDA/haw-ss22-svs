DIR="/home/otto/tls"
DIR_ROOT="/home/otto/tls/root"
DIR_INTR="/home/otto/tls/intermediate"
DIR_LEAF="/home/otto/tls/leaf"

rm -f $DIR_INTR/index $DIR_INTR/index.attr $DIR_INTR/serial $DIR_INTR/intermediate.csr
touch $DIR_INTR/index
echo 00 > $DIR_INTR/serial

openssl req -new -key $DIR_INTR/intermediate.key -out $DIR_INTR/intermediate.csr -config $DIR_INTR/intermediate_req.conf
openssl ca -in $DIR_INTR/intermediate.csr -out $DIR_INTR/intermediate.pem -config $DIR_ROOT/root.conf -extfile $DIR_ROOT/root.ext -days 730

openssl req -new -key $DIR_LEAF/leaf.key -out $DIR_LEAF/leaf.csr -config $DIR_LEAF/leaf_req.conf
openssl ca -in $DIR_LEAF/leaf.csr -out $DIR_LEAF/leaf.pem -config $DIR_INTR/intermediate.conf -extfile $DIR_INTR/intermediate.ext -days 365

cat $DIR_LEAF/leaf.pem $DIR_INTR/intermediate.pem $DIR_ROOT/root.pem > $DIR/svs23.pem

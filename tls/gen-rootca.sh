DIR="/home/otto/tls/root"

rm -f $DIR/index $DIR/index.attr $DIR/serial $DIR/root.csr
touch $DIR/index
echo 00 > $DIR/serial

openssl req -new -key $DIR/root.key -out $DIR/root.csr -config $DIR/root_req.conf
openssl ca -in $DIR/root.csr -out $DIR/root.pem -config $DIR/root.conf -selfsign -extfile $DIR/root.ext -days 1095

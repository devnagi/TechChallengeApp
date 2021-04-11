#!/bin/sh -x

# This will run tcpdump and offload it to the specified S3 bucket, if the ENV TCPDUMP_BUCKET is supplied.
if [ ! -z ${TCPDUMP_BUCKET+x} ] ; then

  echo "Running the tcpdump process..."
  pcap="/tmp/tcpdump-$HOSTNAME.pcap"
  tcpdump -nn -i ${INTERFACE} -c${PKT_COUNT} ${FILTER} -w ${pcap}
  
  echo "PCAP file produced"
  ls -ltr ${pcap}

  echo "Copying PCAP to Bucket $TCPDUMP_BUCKET"
  aws s3 cp ${pcap} s3://${TCPDUMP_BUCKET}/tcpdumps/

else

  echo "Please define variables: TCPDUMP_BUCKET, INTERFACE, PKT_COUNT, FILTER, pcap, "

fi
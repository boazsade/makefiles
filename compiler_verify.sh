INCLUDE_DIR_PATH=/usr/include/sys
UBUNTU_INCLUDE_DIR=/usr/include/x86_64-linux-gnu
if [ ! -d ${INCLUDE_DIR_PATH} ]; then
    echo you dont have include dir ${INCLUDE_DIR_PATH} required for successful building here
   if [ ${USER} = 'root' ]; then
      echo -n "would you like to create link to this direcotry? <Y/n> " 
   else
       echo "you need to either run this script as root or create link between ${UBUNTU_INCLUDE_DIR} and ${INCLUDE_DIR_PATH}"
       exit 1
   fi
fi
exit 0

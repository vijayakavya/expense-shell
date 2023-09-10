source common.sh

component=frontend
echo Installing Nginx

dnf install nginx -y &>>$log_file

if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Placing Expense Config File in Nginx
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

echo Removing Old Nginx Content

rm -rf /usr/share/nginx/html/* &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILED
fi

cd /usr/share/nginx/html

download_and_extract

echo Starting nginx Service
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
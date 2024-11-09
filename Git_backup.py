from email.message import EmailMessage
import ssl
import smtplib
import sys


email_sender = 'sender enail'
email_password = 'key' #Sixteen digit key to access google mail
email_reciver = 'reciver email'


#main function
def send_gmail(subject, body):
    em = EmailMessage()
    em['From'] = email_sender
    em['To'] = email_reciver
    em['Subject'] = subject
    em.set_content(body)
    
    #For establishing an encrypted link between server a client
    context = ssl.create_default_context()

    #Define port and server SMTP && Set vatiables for sending email
    with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
        smtp.login(email_sender, email_password)
        smtp.sendmail(email_sender, email_reciver, em.as_string())

if __name__=="__main__":
    subject = sys.argv[1]
    body = sys.argv[2]
    send_gmail(subject, body)
    

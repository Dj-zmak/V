FROM ubuntu:latest

# প্রয়োজনীয় টুলস ইনস্টল
RUN apt-get update && apt-get install -y openssh-server sudo

# SSH ডিরেক্টরি তৈরি
RUN mkdir /var/run/sshd

# ১. রুট পাসওয়ার্ড সেট করা (আপনার নাম Arafat দেওয়া হয়েছে)
RUN echo 'root:Arafat' | chpasswd

# ২. SSH কনফিগারেশন পরিবর্তন (যাতে পাসওয়ার্ড কাজ করে)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# ৩. এনভায়রনমেন্ট ফিক্স (রেলওয়ের জন্য জরুরি)
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

# ৪. সার্ভিস চালু রাখা
CMD ["/usr/sbin/sshd", "-D"]

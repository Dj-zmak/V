# ১. বেস ইমেজ হিসেবে Ubuntu ব্যবহার করা হচ্ছে
FROM ubuntu:latest

# ২. প্রয়োজনীয় প্যাকেজ আপডেট এবং ইনস্টল (SSH, Curl, Python ইত্যাদি)
RUN apt-get update && apt-get install -y \
    openssh-server \
    curl \
    git \
    python3 \
    python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ৩. SSH কনফিগারেশন (পোর্ট ২২ এর জন্য)
RUN mkdir /var/run/sshd
RUN echo 'root:Arafat' | chpasswd 
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ৪. ওয়ার্কিং ডিরেক্টরি সেট করা
WORKDIR /app

# ৫. পোর্ট এক্সপোজ করা (রেলওয়ে সাধারণত ৮MD বা ২২ পোর্ট ব্যবহার করে)
EXPOSE 22 8080

# ৬. SSH সার্ভিস স্টার্ট করা এবং কন্টেইনার সচল রাখা
CMD ["/usr/sbin/sshd", "-D"]

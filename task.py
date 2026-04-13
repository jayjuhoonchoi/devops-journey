import datetime

# 4:58

now = datetime.datetime.now()
hour = now.hour

print(f"Current hour: {hour}")

if hour < 12:
    print("Good morning! Focus on PTE Speaking practice.")
elif 12 <= hour < 18:
    print("Good afternoon! Let's build some Linux skills.")
else:
    print("Good evening! Time to update your GitHub.")

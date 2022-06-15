with open("nginxbody.txt", "r") as f:
    data = f.read().split()
    # print(data)
f.close()

result = max(data, key=data.count)
print("the words that occurred the most times on the default welcome page is : ", result)

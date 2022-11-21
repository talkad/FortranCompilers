import matplotlib.pyplot as plt

with open('exe_time.log', 'r') as f:
    exe_time = f.read()

times = list(map(float, exe_time.split('\n')[:-1]))

plt.title('strong scaling')
plt.plot(list(range(1,len(times) + 1)), times)
plt.xlabel('num threads')
plt.ylabel('time')
plt.show()
import matplotlib.pyplot as plt



plt.title('strong scaling')
plt.xlabel('num threads')
plt.ylabel('time')

for compiler in ['ifort', 'ifort_o1', 'ifort_o2', 'ifort_o3']:
    with open(f'exe_time_{compiler}.log', 'r') as f:
        exe_time = f.read()

    times = list(map(float, exe_time.split('\n')[:-1]))
    plt.plot(list(range(1,len(times) + 1)), times, label=compiler)

plt.legend()
plt.show()
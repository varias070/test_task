test_data = ["Андрей 9",
             "Василий 11",
             "Роман 7",
             "X Æ A-12 45",
             "Иван Петров 3",
             "Андрей 6",
             "Роман 11",
             ]

ordered_data = {}  # {name: {hours: [int], sum: int}, ..}
for data in test_data:
    split_data = data.split(" ")

    if len(split_data) != 2:
        continue

    name = split_data[0]
    hours = int(split_data[1])

    if name not in ordered_data:
        value = {"hours": [hours], "sum": hours}
        ordered_data[name] = value

    else:
        worker = ordered_data[name]
        worker["hours"].append(hours)
        worker["sum"] += hours

for worker in ordered_data.items():
    print(worker[0], *worker[1]["hours"], "sum:", worker[1]["sum"])

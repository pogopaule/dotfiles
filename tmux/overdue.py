#! python

from pathlib import Path
import re
import datetime

work_dir = Path('/home/pogopaule/.nb/')

all_todos = work_dir.glob('**/*.todo.md')

due_next_seven_days = 0
due_today = 0
overdue = 0

regex = r'^## Due\n\n^(\d{4}-\d{2}-\d{2})'

for todo_file in all_todos:
    with todo_file.open('r') as file_handle:
        search_result = re.search(regex, file_handle.read(), re.MULTILINE)
        if search_result:
            date_str = search_result.group(1)
            date = datetime.date.fromisoformat(date_str)
            if date < datetime.date.today():
                overdue += 1
            if date == datetime.date.today():
                due_today += 1
            if date > datetime.date.today() and date <= datetime.date.today() + datetime.timedelta(days=7):
                due_next_seven_days += 1

if overdue > 0:
    overdue = f' {overdue}'

print(overdue, due_today, due_next_seven_days, end='')

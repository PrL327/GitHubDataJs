### This the code we used to produce the graphs in the notebook
### We used the plotly library
import plotly as py
from plotly.graph_objs import *
import pandas

### Graph for the Top 15 used languages on github
col = ['name', 'occurences', '']
csv_data = pandas.read_csv('most_languages.csv', names=col)
lang = csv_data.name.tolist()
occ = csv_data.occurences.tolist()
lang.pop(0)
occ.pop(0)
x = lang
y = occ

py.offline.init_notebook_mode(connected=True)

layout = Layout(
    title='Top 15 Languages',
    xaxis=dict(
        title='Languages',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    )),
    yaxis=dict(
        title='Occurences',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    ))
)

py.offline.iplot({
    "data": [Scatter(x=lang, y=occ)],
    "layout": layout
})

### Graph for the Least 15 used languages on github
col = ['name', 'occurences', '']
csv_data = pandas.read_csv('least_languages.csv', names=col)
lang = csv_data.name.tolist()
occ = csv_data.occurences.tolist()
lang.pop(0)
occ.pop(0)
x = lang
y = occ

layout = Layout(
    title='Least Used 15 Languages',
    xaxis=dict(
        title='Languages',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    )),
    yaxis=dict(
        title='Occurences',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    ))
)


py.offline.iplot({
    "data": [Scatter(x=lang, y=occ)],
    "layout": layout
})


### Graph for 15 languages that use up the most bytes on github

col = ['name', 'totalBytes', '']
csv_data = pandas.read_csv('most_bytes.csv', names=col)
lang = csv_data.name.tolist()
lang.pop(0)
byte = csv_data.totalBytes.tolist()
byte.pop(0)


x = lang
y = byte

trace = Scatter(
    x=lang,
    y=byte,
    fill='tozeroy'
)


labels = lang
values = byte

layout = Layout(
    xaxis=dict(
        title='Languages',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    )),
    yaxis=dict(
        title='Bytes',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    ))
)
py.offline.iplot({"data": [trace], "layout": layout})

### 15 Languages that use the least amount of bytes on Github
col = ['name', 'totalBytes', '']
csv_data = pandas.read_csv('least_bytes.csv', names=col)
lang = csv_data.name.tolist()
lang.pop(0)
byte = csv_data.totalBytes.tolist()
byte.pop(0)

x = lang
y = byte

trace = Scatter(
    x=lang,
    y=byte,
    fill='tozeroy'
)


labels = lang
values = byte

layout = Layout(
    xaxis=dict(
        title='Languages',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    )),
    yaxis=dict(
        title='Bytes',
        titlefont=dict(
            family='Arial, arial',
            size=18,
            color='#7f7f7f'
    ))
)
py.offline.iplot({"data": [trace], "layout": layout})
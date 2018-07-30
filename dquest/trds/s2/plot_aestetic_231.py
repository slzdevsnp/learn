
import pandas as pd
import matplotlib.pyplot as plt

from pprint import pprint as pp

women_degrees = pd.read_csv('percent-bachelors-degrees-women-usa.csv')

pp(women_degrees.info() )

pp(women_degrees.head())
pp(women_degrees.describe())


fig, ax = plt.subplots()
ax.plot(women_degrees['Year'],women_degrees['Biology'])
plt.show()


#4
plt.plot(women_degrees['Year'], women_degrees['Biology'], c='blue', label='Women')
plt.plot(women_degrees['Year'], 100-women_degrees['Biology'], c='green', label='Men')
plt.legend(loc='upper right')
plt.title('Percentage of Biology Degrees Awarded By Gender')
plt.show()



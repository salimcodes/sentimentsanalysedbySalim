# sentiments-analysed-by-Salim


## Description

Welcome to my project! This is an artificial intelligence app made in Python and the Flask framework and fully powered by Microsoft Azure. It enables users to identify the emotional tone behind a body of text - primarily applicable with movie reviews. With this app, you can rate how positive or negative a movie review is and hence the overall rating for a movie.

## Contribution

We welcome any and all contributions! Here are some ways you can get started:

- Report bugs: If you encounter any bugs, please let us know. Open up an issue and let us know the problem.
- Contribute code: If you are a developer and want to contribute, follow the instructions below to get started!
- Suggestions: If you don't want to code but have some awesome ideas, open up an issue explaining some updates or imporvements you would like to see!
- Documentation: If you see the need for some additional documentation, feel free to add some!

## Instructions
- Fork this repository
- Clone the forked repository
- Add your contributions (code or documentation)
- Commit and push
- Wait for pull request to be merged


## How to Install and Run the Project Locally

You will find the [url](https://sentimentsanalysedbysalim.azurewebsites.net/) for the deployed version of the app on the right-hand pane.

### Testing Flask App locally

Using the terminal;

Clone the repository

```
git clone https://github.com/salimcodes/sentimentsanalysedbySalim.git
cd sentimentsanalysedbySalim
```


Thereafter, create a virtual environment named `mypython`.

```
# Windows
python -m venv myypython

# macOS or Linux
python -m venv myypython
```

Activate the created virtual environment
```
# Windows
myypython\Scripts\activate

#macOS or Linux
source ./myypython/bin/activate
```

Then install the necessary dependencies needed.

``` 
pip install -r requirements.txt
```

Run the flask app locally

```
flask run
```


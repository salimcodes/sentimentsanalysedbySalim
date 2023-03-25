# This example requires environment variables named "LANGUAGE_KEY" and "LANGUAGE_ENDPOINT"
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential
from dotenv import load_dotenv
load_dotenv()
import requests, os, uuid, json
from flask import Flask, redirect, url_for, request, render_template, session

app = Flask(__name__)

language_key = os.getenv("LANGUAGE_KEY")
language_endpoint = os.getenv("LANGUAGE_ENDPOINT")
def authenticate_client():
    ta_credential = AzureKeyCredential(language_key)
    text_analytics_client = TextAnalyticsClient(
            endpoint=language_endpoint, 
            credential=ta_credential)
    return text_analytics_client

client = authenticate_client()

@app.route('/', methods=['GET'])
def index():
    return render_template('index.html')

@app.route('/', methods=['POST'])
def index_post():
    # Read the values from the form
    original_text = request.form['text']
    documents = [original_text]


    result = client.analyze_sentiment(documents, show_opinion_mining=True)
    doc_result = [doc for doc in result if not doc.is_error]

    positive_reviews = [doc for doc in doc_result if doc.sentiment == "positive"]
    negative_reviews = [doc for doc in doc_result if doc.sentiment == "negative"]

    positive_mined_opinions = []
    mixed_mined_opinions = []
    negative_mined_opinions = []

    for document in doc_result:
        sentiment = document.sentiment
        positive_confidence_scores = document.confidence_scores.positive
        negative_confidence_scores = document.confidence_scores.negative
        neutral_confidence_scores = document.confidence_scores.neutral
    return render_template(
        'results.html', 
        sentiment = sentiment, 
        positive_confidence_scores = positive_confidence_scores,
        negative_confidence_scores = negative_confidence_scores,
        neutral_confidence_scores = neutral_confidence_scores
        )

from flask import Flask, render_template, request, jsonify
import pickle
import json
import numpy as np

app = Flask(__name__)

# Load trained model and data columns
with open('/home/lakshay7216/mysite/NYHousemodel.pickle', 'rb') as file:
    model = pickle.load(file)

with open('/home/lakshay7216/mysite/columns.json', 'r') as file:
    data_columns = json.load(file)['data_columns']

def predict_price(sublocality, type_, propertysqft, beds, bath):
    # Convert categorical inputs to one-hot encoding
    input_data = [0] * len(data_columns)
    input_data[data_columns.index(sublocality)] = 1
    input_data[data_columns.index(type_)] = 1
    input_data[data_columns.index('propertysqft')] = propertysqft
    input_data[data_columns.index('beds')] = beds
    input_data[data_columns.index('bath')] = bath

    # Make prediction
    prediction = model.predict([input_data])[0]
    return abs(prediction)  # Return absolute value of prediction

@app.route('/')
def home():
    return render_template('app.html')

@app.route('/listings')
def property_listings():
    return render_template('listings.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        sublocality = request.form['sublocality']
        type_ = request.form['type']
        propertysqft = float(request.form['propertysqft'])
        beds = int(request.form['beds'])
        bath = int(request.form['bath'])

        prediction = abs(predict_price(sublocality, type_, propertysqft, beds, bath))
        return jsonify({'prediction': prediction})
    else:
        return jsonify({'error': 'Method not allowed'})

if __name__ == '__main__':
    app.run(debug=True)

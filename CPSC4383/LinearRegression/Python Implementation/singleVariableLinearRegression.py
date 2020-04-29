from numpy import loadtxt, zeros, ones, array, linspace, logspace
from pylab import scatter, show, title, xlabel, ylabel, plot, contour

#################################################
#            Data Initialization
#################################################

# Load data
data = loadtxt('extdata1.csv', delimiter=',')

# Split data for arithmetic
x = data[:, 0]
y = data[:, 1]

# Set Constants
iterations = 1500
alpha = 0.01

#Insert Bias Column to the data and rename y
features = ones(shape=(y.size, 2))
features[:, 1] = x
targets = y

#Initialize theta parameters
theta = zeros(shape=(2, 1))


#################################################
#            Function Definitions
#################################################

def computeCost(x, y, theta):
    #Number of training samples
    predictions = x.dot(theta).flatten()
    sqErrors = (predictions - y) ** 2
    cost = (1.0 / (2 * y.size)) * sqErrors.sum()
    return cost

def gradientDescent(x, y, theta, alpha, iterations):
    costHistory = zeros(shape=(iterations, 1))

    for i in range(iterations):
        predictions = x.dot(theta).flatten()
        x1Errors = (predictions - y) * x[:, 0]
        x2Errors = (predictions - y) * x[:, 1]
        theta[0][0] = theta[0][0] - alpha * (1.0 / y.size) * x1Errors.sum()
        theta[1][0] = theta[1][0] - alpha * (1.0 / y.size) * x2Errors.sum()
        costHistory[i, 0] = computeCost(x, y, theta)

    return theta, costHistory


#################################################
#               Run
#################################################

theta, costHistory = gradientDescent(features, targets, theta, alpha, iterations)
predict1 = array([1, 3.5]).dot(theta).flatten()
predict2 = array([1, 7.0]).dot(theta).flatten()
results = features.dot(theta).flatten()

#Plot the data
scatter(x, y, marker='o', c='b')
title ('Profits distribution')
xlabel('Population of City in 10,000s')
ylabel('Profit in $10,000s')
plot(x, results)
show()

from numpy import loadtxt, zeros, ones, array, linspace, logspace, mean, std, arange
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from pylab import scatter, plot, show, title, xlabel, ylabel

#################################################
#            Function Definitions
#################################################
def normalizeFeatures(features):
    rMean = []
    rStdDev = []
    norm = features
    
    for i in range(features.shape[1]):
        m = mean(features[:, i])
        s = std(features[:, i])
        rMean.append(m)
        rStdDev.append(s)
        norm[:, i] = (norm[:, i] - m) / s

    return norm, rMean, rStdDev


def computeCost(features, targets, theta):
    sqErrors = (features.dot(theta) - targets)
    cost = (1.0 / (2 * targets.size)) * sqErrors.T.dot(sqErrors)
    return cost


def gradientDescent(features, targets, theta, alpha, iterations):
    costHistory = zeros(shape = (iterations, 1))

    for i in range(iterations):
        prediction = features.dot(theta)
        for it in range(theta.size):
            temp = features[:, it]
            temp.shape = (targets.size, 1)
            x1Errors = (prediction - targets) * temp
            theta[it][0] = theta[it][0] - alpha * (1.0 / targets.size) * x1Errors.sum()

        costHistory[i, 0] = computeCost(features, targets, theta)

    return theta, costHistory


#################################################
#            Data Initialization
#################################################

# Load data and split
data = loadtxt('extdata2.csv', delimiter=',')
x = data[:, :2]
y = data[:, 2]

# Normalize and order data
targets = y
targets.shape = (targets.size, 1)
x, rMean, rStdDev = normalizeFeatures(x)

# Initialize Constants
iterations = 10000
alpha = 0.001

#Insert Bias Column to the data
features = ones(shape=(targets.size, 3))
features[:, 1:3] = x


# Initialize theta
theta = zeros(shape = (3, 1))


#################################################
#                    Run
#################################################

theta, costHistory = gradientDescent(features, targets, theta, alpha, iterations)
plot(arange(iterations), costHistory)
title('Price Distribution')
xlabel('Iterations')
ylabel('Cost Function')
show()

prediction = array([1.0, ((1650.0 - rMean[0]) / rStdDev[0]), ((3 - rMean[1]) / rStdDev[1])]).dot(theta)
#print('Predicted price: %f' % prediction)

'''
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
n = 100
for c, m, zl, zh in [('r', 'o', -50, -25)]:
    xs = data[:, 0]
    ys = data[:, 1]
    zs = data[:, 2]
    ax.scatter(xs, ys, zs, c=c, marker=m)
ax.set_xlabel('Size of the House')
ax.set_ylabel('Number of Bedrooms')
ax.set_zlabel('Price of the House')
plt.show()
'''



import util

"""
Data sturctures we will use are stack, queue and priority queue.

Stack: first in last out
Queue: first in first out
    collection.push(element): insert element
    element = collection.pop() get and remove element from collection

Priority queue:
    pq.update('eat', 2)
    pq.update('study', 1)
    pq.update('sleep', 3)
pq.pop() will return 'study' because it has highest priority 1.

"""

"""
problem is a object has 3 methods related to search state:

problem.getStartState()
Returns the start state for the search problem.

problem.isGoalState(state)
Returns True if and only if the state is a valid goal state.

liebiao .getChildren(state)
For a givlieben state, this should return a list of tuples, (next_state,
step_cost), where 'next_state' is a child to the current state, 
and 'step_cost' is the incremental cost of expanding to that child.

"""
def myDepthFirstSearch(problem):
    visited = {}
    # Python list
    frontier = util.Stack()

    frontier.push((problem.getStartState(), None))

    while not frontier.isEmpty():
        state, prev_state = frontier.pop()

        if problem.isGoalState(state):
            solution = [state]
            while prev_state != None:
                solution.append(prev_state)
                prev_state = visited[prev_state]
            # return the adverse of solution
            return solution[::-1]                
        
        if state not in visited:
            visited[state] = prev_state

            for next_state, step_cost in problem.getChildren(state):
                frontier.push((next_state, state))

    return []

def myBreadthFirstSearch(problem):
    visited = {}
    # Python list
    frontier = util.Queue()

    frontier.push((problem.getStartState(), None))

    while not frontier.isEmpty():
        state, prev_state = frontier.pop()

        if problem.isGoalState(state):
            solution = [state]
            while prev_state != None:
                solution.append(prev_state)
                prev_state = visited[prev_state]
            # return the adverse of solution
            return solution[::-1]                
        
        if state not in visited:
            visited[state] = prev_state

            for next_state, step_cost in problem.getChildren(state):
                frontier.push((next_state, state))
    
    return []

def myAStarSearch(problem, heuristic):
    visited = {}

    frontier = util.PriorityQueue()
    start_state = problem.getStartState()
    frontier.update((start_state, None, 0), heuristic(start_state))

    while not frontier.isEmpty():
        state, prev_state, cost = frontier.pop()

        if problem.isGoalState(state):
            solution = [state]
            while prev_state != None:
                solution.append(prev_state)
                prev_state = visited[prev_state]
            # return the adverse of solution
            return solution[::-1]  

        if state not in visited:
            visited[state] = prev_state

            for next_state, step_cost in problem.getChildren(state):
                next_cost = cost + step_cost
                frontier.update((next_state, state, next_cost), heuristic(next_state) + next_cost)
                
    return []

"""
Game state has 4 methods we can use.

state.isTerminated()
Return True if the state is terminated. We should not continue to search if the state is terminated.

state.isMe()
Return True if it's time for the desired agent to take action. We should check this function to determine whether an agent should maximum or minimum the score.

state.getChildren()
Returns a list of legal state after an agent takes an action.

state.evaluateScore()
Return the score of the state. We should maximum the score for the desired agent.

"""
class MyMinimaxAgent():

    def __init__(self, depth):
        self.depth = depth

    def minimax(self, state, depth):
        if state.isTerminated():
            return None, state.evaluateScore()    
        if state.isMe() and depth == 0:
            return state, state.evaluateScore()
        if state.isMe():
            depth -= 1    
        # initialize
        best_state, best_score = None, -float('inf') if state.isMe() else float('inf')

        for child in state.getChildren():
            # YOUR CODE HERE
            _, current_score = self.minimax(child, depth)
            # max
            if state.isMe():
                if current_score >  best_score:
                    best_state = child
                    best_score = current_score
            # min
            else: 
                if current_score < best_score:
                    best_state = child
                    best_score = current_score
        
        return best_state, best_score

    def getNextState(self, state):
        best_state, _ = self.minimax(state, self.depth)
        return best_state

class MyAlphaBetaAgent():

    def __init__(self, depth):
        self.depth = depth

        
    def alpha_beta(self, state, depth, alpha, beta):
        if state.isTerminated():
            return None, state.evaluateScore()    
        if state.isMe() and depth == 0:
            return state, state.evaluateScore()
        if state.isMe():
            depth -= 1    
        # initialize
        best_state, best_score = None, -float('inf') if state.isMe() else float('inf')

        for child in state.getChildren():
            # YOUR CODE HERE
            _, current_score = self.alpha_beta(child, depth, alpha, beta)
            # max
            if state.isMe():
                if current_score > beta:
                    return child, current_score
                alpha = max(alpha, current_score)
                if current_score >  best_score:
                    best_state = child
                    best_score = current_score
            # min
            else: 
                if current_score < alpha:
                    return child, current_score
                beta = min(beta, current_score)
                if current_score < best_score:
                    best_state = child
                    best_score = current_score
        
        return best_state, best_score

    def getNextState(self, state):
    # YOUR CODE HERE
        best_state, _ = self.alpha_beta(state, self.depth, -float('inf'), float('inf'))
        return best_state
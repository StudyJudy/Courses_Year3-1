/*
实现词法分析器核心构造算法: 
正则表达式->NFA的Thompson构造法、
NFA->DFA的子集构造法、
DFA的最小化算法
*/
#include <iostream>
#include <string>
#include <vector>
#include <set>
#include <map>
#include <stack>
#include <unordered_set>
#include <queue>
#include <deque>
#include <algorithm>
using namespace std;

// 定义 State 类,表示 NFA/DFA 中的状态
class State 
{
public:
    bool isEnd;// 表示该状态是否是终止状态
    map<char, State*> transition;// 存储状态的字符转移关系
    vector<State*> epsilonTransitions;// 存储状态的 epsilon 转移关系

    State(bool isEnd) : isEnd(isEnd) {}// 构造函数，用于初始化状态
};

// 定义 NFA 类，表示非确定有限自动机
class NFA 
{
public:
    State* start;// NFA 的起始状态
    State* end;// NFA 的终止状态

    // 构造函数，用于初始化 NFA
    NFA(State* start, State* end) : start(start), end(end) {}
};

// 定义 DFA 类，表示确定有限自动机
class DFA
{
public:
    set<State*> startStates;// DFA 的起始状态集合
    set<State*> endStates;// DFA 的终止状态集合
    map<set<State*>, map<char, set<State*>>> transitions;// 存储 DFA 的状态转移关系
    
    // 构造函数，用于初始化 DFA
    DFA(set<State*> startStates, set<State*> endStates)
        : startStates(startStates), endStates(endStates) {}
};

// 添加 epsilon 转移关系
void addEpsilonTransition(State* from, State* to)
{
    from->epsilonTransitions.push_back(to);
}

// 添加字符转移关系
void addTransition(State* from, State* to, char symbol)
{
    from->transition[symbol] = to;
}

// 从字符创建 NFA
NFA* fromSymbol(char symbol)
{
    State* start = new State(false); //创建了一个新的起始状态 start，并将其标记为非终止状态
    State* end = new State(true); //创建了一个新的终止状态 end，并将其标记为终止状态
    addTransition(start, end, symbol);//调用 addTransition 函数，将起始状态 start 和终止状态 end 之间添加一个字符转移，其中 symbol 是传递给 fromSymbol 函数的字符参数

    return new NFA(start, end);//函数返回一个指向新创建的NFA对象的指针，该NFA仅包含一个字符转移，该字符转移从起始状态到终止状态。
}

// 创建连接操作的 NFA
NFA* concat(NFA* first, NFA* second)
{
    //调用 addEpsilonTransition 函数，在第一个NFA的终止状态 first->end 和第二个NFA的起始状态 second->start 之间添加一个 epsilon 转移。
    addEpsilonTransition(first->end, second->start);
    //将第一个NFA的原终止状态 first->end 标记为非终止状态，因为连接操作后，原来的终止状态不再是终止状态。
    first->end->isEnd = false;
    //创建一个新的NFA对象，该对象的起始状态是第一个NFA的起始状态 first->start，终止状态是第二个NFA的终止状态 second->end。这个新的NFA表示了连接操作的结果。
    return new NFA(first->start, second->end);
}

// 创建选择操作的 NFA
NFA* unionNFA(NFA* first, NFA* second)
{
    State* start = new State(false);//创建一个新的起始状态 start，并将其标记为非终止状态

    //调用 addEpsilonTransition 函数，分别将新的起始状态 start 与两个输入NFA的起始状态 first->start 和 second->start 之间添加两个 epsilon 转移。
    //从新的起始状态可以通过 epsilon 转移到两个输入NFA的起始状态。
    addEpsilonTransition(start, first->start);//
    addEpsilonTransition(start, second->start);

    State* end = new State(true);//创建一个新的终止状态 end，并将其标记为终止状态

    //将第一个输入NFA的终止状态 first->end 和第二个输入NFA的终止状态 second->end 与新的终止状态 end 之间添加两个 epsilon 转移。
    addEpsilonTransition(first->end, end);
    first->end->isEnd = false;
    addEpsilonTransition(second->end, end);
    second->end->isEnd = false;//将两个输入NFA的原终止状态标记为非终止状态

    return new NFA(start, end);
}

// 创建闭包操作的 NFA
NFA* closure(NFA* nfa)
{
    State* start = new State(false);//创建一个新的起始状态 start，并将其标记为非终止状态
    State* end = new State(true);//创建了一个新的终止状态 end，并将其标记为终止状态

    addEpsilonTransition(start, end);//调用 addEpsilonTransition 函数，将新的起始状态 start 与新的终止状态 end 之间添加一个 epsilon 转移。这是闭包操作的起始和终止状态之间的 epsilon 转移
    addEpsilonTransition(start, nfa->start);//将新的起始状态 start 与输入NFA的起始状态 nfa->start 之间添加一个 epsilon 转移。这允许从新的起始状态通过 epsilon 转移到输入NFA的起始状态。
    addEpsilonTransition(nfa->end, end);//将输入NFA的终止状态 nfa->end 与新的终止状态 end 之间添加一个 epsilon 转移。这允许从输入NFA的终止状态通过 epsilon 转移到新的终止状态。
    addEpsilonTransition(nfa->end, nfa->start);//将输入NFA的终止状态 nfa->end 与输入NFA的起始状态 nfa->start 之间添加一个 epsilon 转移。
    nfa->end->isEnd = false;//将输入NFA的原终止状态标记为非终止状态，因为在闭包操作后，它不再是终止状态

    return new NFA(start, end);
}

// 将中缀表达式转换为后缀表达式
string shunt(string infix)
{
    map<char, int> specials = { {'*', 50}, {'.', 40}, {'|', 30} };
    string postfix = "";//转换后的后缀表达式
    stack<char> stack;//处理操作符和括号

    for (char c : infix) //遍历中缀表达式中的每个字符
    {
        if (c == '(')//如果字符是左括号，将其压入栈
        {
            stack.push(c);
        }
        //如果字符是右括号，弹出栈中的操作符并添加到后缀表达式中，直到遇到左括号。然后移除左括号
        else if (c == ')')
        {
            while (!stack.empty() && stack.top() != '(')
            {
                postfix += stack.top();
                stack.pop();
            }
            // 移除 '('
            stack.pop();
        }
        //如果字符是操作符，比较其优先级与栈顶操作符的优先级。
        //如果栈顶操作符的优先级高于或等于当前操作符，弹出栈顶操作符并添加到后缀表达式中，直到栈为空或栈顶操作符的优先级低于当前操作符。
        //然后将当前操作符压入栈。
        else if (specials.find(c) != specials.end())
        {
            while (!stack.empty() && specials[c] <= specials[stack.top()])
            {
                postfix += stack.top();
                stack.pop();
            }
            stack.push(c);
        }
        //如果字符是字母或其他字符，直接将其添加到后缀表达式中
        else
        {
            postfix += c;
        }
    }
    //处理完所有字符后，将栈中剩余的操作符依次弹出并添加到后缀表达式中
    while (!stack.empty()) 
    {
        postfix += stack.top();
        stack.pop();
    }
    return postfix;
}

// 将后缀表达式转换为 NFA
NFA* toNFA(string postfix)
{
    stack<NFA*> stack;
    //遍历后缀表达式中的每个字符
    for (char c : postfix)
    {
        //如果字符是点号（连接操作符），从栈中弹出两个NFA对象，然后将它们连接起来，并将新的NFA对象推回栈中。
        if (c == '.')
        {
            NFA* nfa2 = stack.top();
            stack.pop();
            NFA* nfa1 = stack.top();
            stack.pop();
            NFA* newNFA = concat(nfa1, nfa2);
            stack.push(newNFA);
        }
        //如果字符是竖线（选择操作符），从栈中弹出两个NFA对象，然后将它们进行选择操作，并将新的NFA对象推回栈中。
        else if (c == '|') 
        {
            NFA* nfa2 = stack.top();
            stack.pop();
            NFA* nfa1 = stack.top();
            stack.pop();
            NFA* newNFA = unionNFA(nfa1, nfa2);
            stack.push(newNFA);
        }
        //如果字符是星号（闭包操作符），从栈中弹出一个NFA对象，然后将它应用闭包操作，并将新的NFA对象推回栈中。
        else if (c == '*')
        {
            NFA* nfa = stack.top();
            stack.pop();
            NFA* newNFA = closure(nfa);
            stack.push(newNFA);
        }
        //如果字符是字母或其他字符，将它转换为一个NFA对象，并将其推入栈中。
        else
        {
            NFA* nfa = fromSymbol(c);
            stack.push(nfa);
        }
    }

    return stack.top();
}

// 遍历状态和转移关系，并输出
void printNFA(NFA* nfa) 
{
    cout << "Start State: " << nfa->start << endl;
    cout << "End State: " << nfa->end << endl;

    // 遍历状态
    stack<State*> stateStack;
    stateStack.push(nfa->start);

    while (!stateStack.empty()) 
    {
        State* currentState = stateStack.top();
        stateStack.pop();

        cout << "State: " << currentState << (currentState->isEnd ? " (End)" : "") << endl;

        // 遍历字符转移
        for (auto& transition : currentState->transition) 
        {
            cout << "Transition on '" << transition.first << "' to State: " << transition.second << endl;
        }

        // 遍历 epsilon 转移
        for (State* epsilonTransition : currentState->epsilonTransitions) 
        {
            cout << "Epsilon Transition to State: " << epsilonTransition << endl;
            stateStack.push(epsilonTransition);
        }
    }
}

// 计算状态集合的 epsilon 闭包
set<State*> epsilonClosure(set<State*> states)
{
    //将输入的状态集合 states 复制到一个新的状态集合 closure 中，作为起始闭包
    set<State*> closure = states;
    //创建一个栈 stateStack，用于存储需要处理的状态
    stack<State*> stateStack;
    //将输入状态集合中的每个状态压入栈中，以便开始处理
    for (State* state : states)
    {
        stateStack.push(state);
    }
   
    while (!stateStack.empty())
    {
        //从栈中弹出一个状态，作为当前处理的状态
        State* currentState = stateStack.top();
        //从栈中移除已处理的状态
        stateStack.pop();
        //遍历当前状态的 epsilon 转移关系
        for (State* epsilonTransition : currentState->epsilonTransitions)
        {
            //如果找到一个 epsilon 转移的状态 epsilonTransition，并且它不在闭包 closure 中，
            //就将它添加到闭包中，并将它压入栈中，以便后续处理它的 epsilon 转移。
            if (closure.find(epsilonTransition) == closure.end())
            {
                closure.insert(epsilonTransition);
                stateStack.push(epsilonTransition);
            }
        }
    }
    //返回包含原状态集合及其 epsilon 闭包的新状态集合 closure
    return closure;
}

// 构建DFA
DFA* subsetConstruction(NFA* nfa)
{
   //创建一个集合 dfaStates，用于存储DFA的状态集合
    set<set<State*>> dfaStates;
    //创建一个映射 dfaTransitions，用于存储DFA的状态转移关系
    map<set<State*>, map<char, set<State*>>> dfaTransitions;
    //创建一个初始状态集合 initialState，并将NFA的起始状态 nfa->start 添加到其中
    set<State*> initialState;
    initialState.insert(nfa->start);
    //计算 initialState 的 epsilon 闭包，确保包括所有通过 epsilon 转移可达的状态
    initialState = epsilonClosure(initialState);
    //将初始状态集合添加到DFA的状态集合中
    dfaStates.insert(initialState);
    //创建一个队列 stateQueue，用于广度优先搜索DFA状态
    queue<set<State*>> stateQueue;
    //将初始状态集合添加到队列中，以便开始构建DFA
    stateQueue.push(initialState);

    //通过广度优先搜索，逐个处理每个DFA状态
    while (!stateQueue.empty())
    {
        set<State*> currentState = stateQueue.front();
        stateQueue.pop();
        //对于每个字符（在 'a' 到 'z' 之间），
        //计算从当前状态经过字符转移后达到的状态集合，并计算它们的 epsilon 闭包。
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            set<State*> newState;
            // 遍历当前状态集合，查找通过字符 symbol 转移可达的状态
            for (State* state : currentState)
            {
                if (state->transition.find(symbol) != state->transition.end())
                {
                    State* nextState = state->transition[symbol];
                    newState.insert(nextState);
                }
            }
            // 计算新状态集合的 epsilon 闭包
            set<State*> newStateClosure = epsilonClosure(newState);

            //如果得到的状态集合不为空，将其添加到DFA的状态集合中，并记录状态转移关系。
            if (!newStateClosure.empty())
            {
                // 检查新状态是否已存在于DFA状态集合中，如果不存在，将其添加到状态队列
                if (dfaStates.find(newStateClosure) == dfaStates.end())
                {
                    dfaStates.insert(newStateClosure);
                    stateQueue.push(newStateClosure);
                }
                // 记录状态 currentState 经过字符 symbol 转移到 newStateClosure
                dfaTransitions[currentState][symbol] = newStateClosure;
            }
        }
    }
    // 创建 DFA 的起始状态集合
    set<State*> dfaStartStates;
    dfaStartStates.insert(nfa->start);
    dfaStartStates = epsilonClosure(dfaStartStates);

    // 创建 DFA 的终止状态集合
    set<State*> dfaEndStates;

    // 遍历 DFA 的状态集合，寻找终止状态
    for (set<State*> stateSet : dfaStates)
    {
        for (State* state : stateSet)
        {
            if (state->isEnd)
            {
                // 如果状态是终止状态，将其添加到 DFA 的终止状态集合中
                dfaEndStates.insert(stateSet.begin(), stateSet.end());
                break;
            }
        }
    }

    // 创建 DFA 对象，并设置其起始状态、终止状态和状态转移关系
    DFA* dfa = new DFA(dfaStartStates, dfaEndStates);
    dfa->transitions = dfaTransitions;

    return dfa;
}

void printDFA(DFA* dfa)
{
    cout << "DFA States:" << endl;
    // 遍历 DFA 的状态转移映射，其中 stateTransitionPair 是一个 DFA 状态集合到状态转移映射的映射
    for (const auto& stateTransitionPair : dfa->transitions)
    {
        // 当前状态集合
        const set<State*>& stateSet = stateTransitionPair.first;
        cout << "State { ";

        // 打印当前状态集合中的每个状态
        for (State* state : stateSet)
        {
            cout << state << " ";
        }
        cout << "}" << endl;
    }

    cout << "DFA Transitions:" << endl;

    // 再次遍历 DFA 的状态转移映射
    for (const auto& transition : dfa->transitions)
    {
        // 起始状态集合
        const set<State*>& fromStates = transition.first;
        // 符号到目标状态集合的映射
        const map<char, set<State*>>& toStates = transition.second;

        // 遍历字母表中的字符 'a' 到 'z'，检查每个字符的状态转移
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            // 检查当前字符是否有转移
            if (toStates.find(symbol) != toStates.end())
            {
                // 目标状态集合
                const set<State*>& nextStateSet = toStates.at(symbol);

                cout << "Transition from { ";

                // 打印起始状态集合中的每个状态
                for (State* state : fromStates)
                {
                    cout << state << " ";
                }
                cout << "} on symbol '" << symbol << "' to { ";

                // 打印目标状态集合中的每个状态
                for (State* state : nextStateSet)
                {
                    cout << state << " ";
                }
                cout << "}" << endl;
            }
        }
    }

    cout << "Start States: { ";

    // 打印 DFA 的起始状态集合中的每个状态
    for (State* state : dfa->startStates)
    {
        cout << state << " ";
    }
    cout << "}" << endl;

    cout << "End States: " ;

    // 打印 DFA 的终止状态集合中的每个状态
    for (State* state : dfa->endStates)
    {
        cout << "State { " << state << " }" << endl;
    }
}
// 这个函数接受两个参数：一个用于检查的状态集合 'group' 和一个目标状态集合 'target'。
bool containsAll(const set<State*>& group, const set<State*>& target)
{
    // 使用 for 循环遍历目标状态集合 'target' 中的每个状态 'state'。
    // 在循环中，我们检查状态 'state' 是否存在于状态集合 'group' 中。
    // 如果状态存在，find() 返回的迭代器不等于 'group.end()'。
    for (State* state : target)
    {
        // 如果状态 'state' 不存在于状态集合 'group'，则返回 false，表示未包含全部目标状态。
        if (group.find(state) == group.end())
        {
            return false;
        }
    }
    // 如果 for 循环完成后仍未返回 false，表示状态集合 'group' 包含了 'target' 中的所有状态，
    return true;
}

// 最小化DFA的算法
DFA* minimizeDFA(DFA* dfa)
{
    // 初始化分组，包含终止状态和非终止状态
    set<set<State*>> P; // 当前分组集合
    set<State*> nonEndStates; // 非终止状态集合
    // 遍历 DFA 的终止状态，并为每个状态创建一个单元素的分组，将其添加到 P 中
    for (State* state : dfa->endStates)
    {
        set<State*> endStateGroup;
        endStateGroup.insert(state);
        P.insert(endStateGroup);
    }
    // 找出 DFA 的非终止状态，将它们添加到单独的分组中，然后将这些分组添加到 P 中
    for (State* state : dfa->startStates)
    {
        if (dfa->endStates.find(state) == dfa->endStates.end())
        {
            nonEndStates.insert(state);
        }
    }

    P.insert(nonEndStates);

    // 迭代合并，直到不能再细分组
    bool changed = true;
    while (changed)
    {
        changed = false;
        set<set<State*>> newP; // 用于存储下一轮的分组

        for (set<State*> group : P)
        {
            // 针对每个字符检查状态是否在同一组中
            map<char, set<State*>> transitionsForGroup;
            for (State* state : group)
            {
                // 对于当前状态 group 中的每个状态 state，检查它们在不同字符下的状态转移目标，
                // 并将这些目标状态分组存储在 transitionsForGroup 中。
                for (char symbol = 'a'; symbol <= 'z'; symbol++)
                {
                    if (state->transition.find(symbol) != state->transition.end())
                    {
                        State* nextState = state->transition[symbol];
                        for (set<State*> nextGroup : P)
                        {
                            if (nextGroup.find(nextState) != nextGroup.end())
                            {
                                transitionsForGroup[symbol] = nextGroup;
                                break;
                            }
                        }
                    }
                }
            }

            // 如果 transitionsForGroup 中包含多个不同的分组，则需要拆分当前分组
            if (transitionsForGroup.size() > 1)
            {
                // 分组内有状态可以跳转到不同的组，需要拆分分组
                changed = true;
                // 将 transitionsForGroup 中的不同分组添加到 newP 中
                for (const auto& transition : transitionsForGroup)
                {
                    newP.insert(transition.second);
                }
            }
            else
            {
                // 如果 transitionsForGroup 中只包含一个分组，将当前分组保持不变
                newP.insert(group);
            }
        }
        // 更新分组集合 P 为新的分组集合 newP
        P = newP;
    }

    // 构建最小化DFA
    set<State*> startStates;
    set<State*> endStates;
    map<set<State*>, map<char, set<State*>>> transitions;
    // 遍历最小化后的分组集合 P
    for (set<State*> group : P)
    {
        // 找出包含初始状态的分组并存储为 startStates
        if (containsAll(group, dfa->startStates))
        {
            startStates = group;
        }
        // 找出包含终止状态的分组并存储为 endStates
        if (containsAll(group, dfa->endStates))
        {
            endStates.insert(group.begin(), group.end());
        }
        // 为每个字符计算状态转移关系，并存储在 transitions 中
        map<set<State*>, set<State*>> transitionsForSymbol;

        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            for (State* state : group)
            {
                if (state->transition.find(symbol) != state->transition.end())
                {
                    State* nextState = state->transition[symbol];

                    for (set<State*> nextGroup : P)
                    {
                        if (containsAll(nextGroup, set<State*>{nextState}))
                        {
                            transitionsForSymbol[group].insert(nextGroup.begin(), nextGroup.end());
                            break;
                        }
                    }
                }
            }
            // 如果 transitionsForSymbol 非空，将其存储在 transitions 中
            if (!transitionsForSymbol.empty())
            {
                transitions[group][symbol] = transitionsForSymbol[group];
            }
        }
    }

    // 构建最小化DFA
    DFA* minimizedDFA = new DFA(startStates, endStates);
    minimizedDFA->transitions = transitions;

    return minimizedDFA;
}

void printMinDFA(DFA* dfa)
{
    cout << "Minimized DFA States:" << endl;
    // 遍历最小化的 DFA 中的状态和状态转移
    for (const auto& stateTransitionPair : dfa->transitions)
    {
        const set<State*>& stateSet = stateTransitionPair.first;
        cout << "State { ";
        // 输出当前状态集合的所有状态
        for (State* state : stateSet)
        {
            cout << state << " ";
        }
        cout << "}" << endl;
    }

    cout << "Minimized DFA Transitions:" << endl;
    for (const auto& transition : dfa->transitions)
    {
        const set<State*>& fromStates = transition.first;
        const map<char, set<State*>>& toStates = transition.second;
        // 遍历 DFA 的状态转移关系
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            if (toStates.find(symbol) != toStates.end())
            {
                const set<State*>& nextStateSet = toStates.at(symbol);

                cout << "Transition from { ";
                // 输出状态转移的起始状态
                for (State* state : fromStates)
                {
                    cout << state << " ";
                }
                cout << "} on symbol '" << symbol << "' to { ";
                // 输出状态转移的目标状态
                for (State* state : nextStateSet)
                {
                    cout << state << " ";
                }
                cout << "}" << endl;
            }
        }
    }

    cout << "Minimized DFA Start States: { ";
    // 输出最小化的 DFA 的起始状态
    for (State* state : dfa->startStates)
    {
        cout << state << " ";
    }
    cout << "}" << endl;

    cout << "Minimized DFA End States: " << endl;
    // 输出最小化的 DFA 的终止状态
    for (State* state : dfa->endStates)
    {
        cout << "State { " << state << " }" << endl;
    }
}

int main()
{
    string regex = "(a|b)*c";
    string postfix = shunt(regex);
    cout << "Postfix Expression: " << postfix << endl;
    cout << endl;

    cout << "Regular Expression -> NFA" << endl;
    string postfix1 = "ab|*c.";
    NFA* nfa = toNFA(postfix1);   
    // 输出 NFA
    printNFA(nfa);
    cout << endl;

    cout << "NFA -> DFA" << endl;
    // 将 NFA 转换为 DFA
    DFA* dfa = subsetConstruction(nfa);
    // 输出 DFA
    printDFA(dfa);
    cout << endl;

    cout << "Minimized DFA" << endl;
    DFA* minDFA = minimizeDFA(dfa);
    printMinDFA(minDFA);
    cout << endl;

    return 0;
}

/*
ʵ�ִʷ����������Ĺ����㷨: 
������ʽ->NFA��Thompson���취��
NFA->DFA���Ӽ����취��
DFA����С���㷨
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

// ���� State ��,��ʾ NFA/DFA �е�״̬
class State 
{
public:
    bool isEnd;// ��ʾ��״̬�Ƿ�����ֹ״̬
    map<char, State*> transition;// �洢״̬���ַ�ת�ƹ�ϵ
    vector<State*> epsilonTransitions;// �洢״̬�� epsilon ת�ƹ�ϵ

    State(bool isEnd) : isEnd(isEnd) {}// ���캯�������ڳ�ʼ��״̬
};

// ���� NFA �࣬��ʾ��ȷ�������Զ���
class NFA 
{
public:
    State* start;// NFA ����ʼ״̬
    State* end;// NFA ����ֹ״̬

    // ���캯�������ڳ�ʼ�� NFA
    NFA(State* start, State* end) : start(start), end(end) {}
};

// ���� DFA �࣬��ʾȷ�������Զ���
class DFA
{
public:
    set<State*> startStates;// DFA ����ʼ״̬����
    set<State*> endStates;// DFA ����ֹ״̬����
    map<set<State*>, map<char, set<State*>>> transitions;// �洢 DFA ��״̬ת�ƹ�ϵ
    
    // ���캯�������ڳ�ʼ�� DFA
    DFA(set<State*> startStates, set<State*> endStates)
        : startStates(startStates), endStates(endStates) {}
};

// ��� epsilon ת�ƹ�ϵ
void addEpsilonTransition(State* from, State* to)
{
    from->epsilonTransitions.push_back(to);
}

// ����ַ�ת�ƹ�ϵ
void addTransition(State* from, State* to, char symbol)
{
    from->transition[symbol] = to;
}

// ���ַ����� NFA
NFA* fromSymbol(char symbol)
{
    State* start = new State(false); //������һ���µ���ʼ״̬ start����������Ϊ����ֹ״̬
    State* end = new State(true); //������һ���µ���ֹ״̬ end����������Ϊ��ֹ״̬
    addTransition(start, end, symbol);//���� addTransition ����������ʼ״̬ start ����ֹ״̬ end ֮�����һ���ַ�ת�ƣ����� symbol �Ǵ��ݸ� fromSymbol �������ַ�����

    return new NFA(start, end);//��������һ��ָ���´�����NFA�����ָ�룬��NFA������һ���ַ�ת�ƣ����ַ�ת�ƴ���ʼ״̬����ֹ״̬��
}

// �������Ӳ����� NFA
NFA* concat(NFA* first, NFA* second)
{
    //���� addEpsilonTransition �������ڵ�һ��NFA����ֹ״̬ first->end �͵ڶ���NFA����ʼ״̬ second->start ֮�����һ�� epsilon ת�ơ�
    addEpsilonTransition(first->end, second->start);
    //����һ��NFA��ԭ��ֹ״̬ first->end ���Ϊ����ֹ״̬����Ϊ���Ӳ�����ԭ������ֹ״̬��������ֹ״̬��
    first->end->isEnd = false;
    //����һ���µ�NFA���󣬸ö������ʼ״̬�ǵ�һ��NFA����ʼ״̬ first->start����ֹ״̬�ǵڶ���NFA����ֹ״̬ second->end������µ�NFA��ʾ�����Ӳ����Ľ����
    return new NFA(first->start, second->end);
}

// ����ѡ������� NFA
NFA* unionNFA(NFA* first, NFA* second)
{
    State* start = new State(false);//����һ���µ���ʼ״̬ start����������Ϊ����ֹ״̬

    //���� addEpsilonTransition �������ֱ��µ���ʼ״̬ start ����������NFA����ʼ״̬ first->start �� second->start ֮��������� epsilon ת�ơ�
    //���µ���ʼ״̬����ͨ�� epsilon ת�Ƶ���������NFA����ʼ״̬��
    addEpsilonTransition(start, first->start);//
    addEpsilonTransition(start, second->start);

    State* end = new State(true);//����һ���µ���ֹ״̬ end����������Ϊ��ֹ״̬

    //����һ������NFA����ֹ״̬ first->end �͵ڶ�������NFA����ֹ״̬ second->end ���µ���ֹ״̬ end ֮��������� epsilon ת�ơ�
    addEpsilonTransition(first->end, end);
    first->end->isEnd = false;
    addEpsilonTransition(second->end, end);
    second->end->isEnd = false;//����������NFA��ԭ��ֹ״̬���Ϊ����ֹ״̬

    return new NFA(start, end);
}

// �����հ������� NFA
NFA* closure(NFA* nfa)
{
    State* start = new State(false);//����һ���µ���ʼ״̬ start����������Ϊ����ֹ״̬
    State* end = new State(true);//������һ���µ���ֹ״̬ end����������Ϊ��ֹ״̬

    addEpsilonTransition(start, end);//���� addEpsilonTransition ���������µ���ʼ״̬ start ���µ���ֹ״̬ end ֮�����һ�� epsilon ת�ơ����Ǳհ���������ʼ����ֹ״̬֮��� epsilon ת��
    addEpsilonTransition(start, nfa->start);//���µ���ʼ״̬ start ������NFA����ʼ״̬ nfa->start ֮�����һ�� epsilon ת�ơ���������µ���ʼ״̬ͨ�� epsilon ת�Ƶ�����NFA����ʼ״̬��
    addEpsilonTransition(nfa->end, end);//������NFA����ֹ״̬ nfa->end ���µ���ֹ״̬ end ֮�����һ�� epsilon ת�ơ������������NFA����ֹ״̬ͨ�� epsilon ת�Ƶ��µ���ֹ״̬��
    addEpsilonTransition(nfa->end, nfa->start);//������NFA����ֹ״̬ nfa->end ������NFA����ʼ״̬ nfa->start ֮�����һ�� epsilon ת�ơ�
    nfa->end->isEnd = false;//������NFA��ԭ��ֹ״̬���Ϊ����ֹ״̬����Ϊ�ڱհ�����������������ֹ״̬

    return new NFA(start, end);
}

// ����׺���ʽת��Ϊ��׺���ʽ
string shunt(string infix)
{
    map<char, int> specials = { {'*', 50}, {'.', 40}, {'|', 30} };
    string postfix = "";//ת����ĺ�׺���ʽ
    stack<char> stack;//���������������

    for (char c : infix) //������׺���ʽ�е�ÿ���ַ�
    {
        if (c == '(')//����ַ��������ţ�����ѹ��ջ
        {
            stack.push(c);
        }
        //����ַ��������ţ�����ջ�еĲ���������ӵ���׺���ʽ�У�ֱ�����������š�Ȼ���Ƴ�������
        else if (c == ')')
        {
            while (!stack.empty() && stack.top() != '(')
            {
                postfix += stack.top();
                stack.pop();
            }
            // �Ƴ� '('
            stack.pop();
        }
        //����ַ��ǲ��������Ƚ������ȼ���ջ�������������ȼ���
        //���ջ�������������ȼ����ڻ���ڵ�ǰ������������ջ������������ӵ���׺���ʽ�У�ֱ��ջΪ�ջ�ջ�������������ȼ����ڵ�ǰ��������
        //Ȼ�󽫵�ǰ������ѹ��ջ��
        else if (specials.find(c) != specials.end())
        {
            while (!stack.empty() && specials[c] <= specials[stack.top()])
            {
                postfix += stack.top();
                stack.pop();
            }
            stack.push(c);
        }
        //����ַ�����ĸ�������ַ���ֱ�ӽ�����ӵ���׺���ʽ��
        else
        {
            postfix += c;
        }
    }
    //�����������ַ��󣬽�ջ��ʣ��Ĳ��������ε�������ӵ���׺���ʽ��
    while (!stack.empty()) 
    {
        postfix += stack.top();
        stack.pop();
    }
    return postfix;
}

// ����׺���ʽת��Ϊ NFA
NFA* toNFA(string postfix)
{
    stack<NFA*> stack;
    //������׺���ʽ�е�ÿ���ַ�
    for (char c : postfix)
    {
        //����ַ��ǵ�ţ����Ӳ�����������ջ�е�������NFA����Ȼ���������������������µ�NFA�����ƻ�ջ�С�
        if (c == '.')
        {
            NFA* nfa2 = stack.top();
            stack.pop();
            NFA* nfa1 = stack.top();
            stack.pop();
            NFA* newNFA = concat(nfa1, nfa2);
            stack.push(newNFA);
        }
        //����ַ������ߣ�ѡ�������������ջ�е�������NFA����Ȼ�����ǽ���ѡ������������µ�NFA�����ƻ�ջ�С�
        else if (c == '|') 
        {
            NFA* nfa2 = stack.top();
            stack.pop();
            NFA* nfa1 = stack.top();
            stack.pop();
            NFA* newNFA = unionNFA(nfa1, nfa2);
            stack.push(newNFA);
        }
        //����ַ����Ǻţ��հ�������������ջ�е���һ��NFA����Ȼ����Ӧ�ñհ������������µ�NFA�����ƻ�ջ�С�
        else if (c == '*')
        {
            NFA* nfa = stack.top();
            stack.pop();
            NFA* newNFA = closure(nfa);
            stack.push(newNFA);
        }
        //����ַ�����ĸ�������ַ�������ת��Ϊһ��NFA���󣬲���������ջ�С�
        else
        {
            NFA* nfa = fromSymbol(c);
            stack.push(nfa);
        }
    }

    return stack.top();
}

// ����״̬��ת�ƹ�ϵ�������
void printNFA(NFA* nfa) 
{
    cout << "Start State: " << nfa->start << endl;
    cout << "End State: " << nfa->end << endl;

    // ����״̬
    stack<State*> stateStack;
    stateStack.push(nfa->start);

    while (!stateStack.empty()) 
    {
        State* currentState = stateStack.top();
        stateStack.pop();

        cout << "State: " << currentState << (currentState->isEnd ? " (End)" : "") << endl;

        // �����ַ�ת��
        for (auto& transition : currentState->transition) 
        {
            cout << "Transition on '" << transition.first << "' to State: " << transition.second << endl;
        }

        // ���� epsilon ת��
        for (State* epsilonTransition : currentState->epsilonTransitions) 
        {
            cout << "Epsilon Transition to State: " << epsilonTransition << endl;
            stateStack.push(epsilonTransition);
        }
    }
}

// ����״̬���ϵ� epsilon �հ�
set<State*> epsilonClosure(set<State*> states)
{
    //�������״̬���� states ���Ƶ�һ���µ�״̬���� closure �У���Ϊ��ʼ�հ�
    set<State*> closure = states;
    //����һ��ջ stateStack�����ڴ洢��Ҫ�����״̬
    stack<State*> stateStack;
    //������״̬�����е�ÿ��״̬ѹ��ջ�У��Ա㿪ʼ����
    for (State* state : states)
    {
        stateStack.push(state);
    }
   
    while (!stateStack.empty())
    {
        //��ջ�е���һ��״̬����Ϊ��ǰ�����״̬
        State* currentState = stateStack.top();
        //��ջ���Ƴ��Ѵ����״̬
        stateStack.pop();
        //������ǰ״̬�� epsilon ת�ƹ�ϵ
        for (State* epsilonTransition : currentState->epsilonTransitions)
        {
            //����ҵ�һ�� epsilon ת�Ƶ�״̬ epsilonTransition�����������ڱհ� closure �У�
            //�ͽ�����ӵ��հ��У�������ѹ��ջ�У��Ա������������ epsilon ת�ơ�
            if (closure.find(epsilonTransition) == closure.end())
            {
                closure.insert(epsilonTransition);
                stateStack.push(epsilonTransition);
            }
        }
    }
    //���ذ���ԭ״̬���ϼ��� epsilon �հ�����״̬���� closure
    return closure;
}

// ����DFA
DFA* subsetConstruction(NFA* nfa)
{
   //����һ������ dfaStates�����ڴ洢DFA��״̬����
    set<set<State*>> dfaStates;
    //����һ��ӳ�� dfaTransitions�����ڴ洢DFA��״̬ת�ƹ�ϵ
    map<set<State*>, map<char, set<State*>>> dfaTransitions;
    //����һ����ʼ״̬���� initialState������NFA����ʼ״̬ nfa->start ��ӵ�����
    set<State*> initialState;
    initialState.insert(nfa->start);
    //���� initialState �� epsilon �հ���ȷ����������ͨ�� epsilon ת�ƿɴ��״̬
    initialState = epsilonClosure(initialState);
    //����ʼ״̬������ӵ�DFA��״̬������
    dfaStates.insert(initialState);
    //����һ������ stateQueue�����ڹ����������DFA״̬
    queue<set<State*>> stateQueue;
    //����ʼ״̬������ӵ������У��Ա㿪ʼ����DFA
    stateQueue.push(initialState);

    //ͨ����������������������ÿ��DFA״̬
    while (!stateQueue.empty())
    {
        set<State*> currentState = stateQueue.front();
        stateQueue.pop();
        //����ÿ���ַ����� 'a' �� 'z' ֮�䣩��
        //����ӵ�ǰ״̬�����ַ�ת�ƺ�ﵽ��״̬���ϣ����������ǵ� epsilon �հ���
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            set<State*> newState;
            // ������ǰ״̬���ϣ�����ͨ���ַ� symbol ת�ƿɴ��״̬
            for (State* state : currentState)
            {
                if (state->transition.find(symbol) != state->transition.end())
                {
                    State* nextState = state->transition[symbol];
                    newState.insert(nextState);
                }
            }
            // ������״̬���ϵ� epsilon �հ�
            set<State*> newStateClosure = epsilonClosure(newState);

            //����õ���״̬���ϲ�Ϊ�գ�������ӵ�DFA��״̬�����У�����¼״̬ת�ƹ�ϵ��
            if (!newStateClosure.empty())
            {
                // �����״̬�Ƿ��Ѵ�����DFA״̬�����У���������ڣ�������ӵ�״̬����
                if (dfaStates.find(newStateClosure) == dfaStates.end())
                {
                    dfaStates.insert(newStateClosure);
                    stateQueue.push(newStateClosure);
                }
                // ��¼״̬ currentState �����ַ� symbol ת�Ƶ� newStateClosure
                dfaTransitions[currentState][symbol] = newStateClosure;
            }
        }
    }
    // ���� DFA ����ʼ״̬����
    set<State*> dfaStartStates;
    dfaStartStates.insert(nfa->start);
    dfaStartStates = epsilonClosure(dfaStartStates);

    // ���� DFA ����ֹ״̬����
    set<State*> dfaEndStates;

    // ���� DFA ��״̬���ϣ�Ѱ����ֹ״̬
    for (set<State*> stateSet : dfaStates)
    {
        for (State* state : stateSet)
        {
            if (state->isEnd)
            {
                // ���״̬����ֹ״̬��������ӵ� DFA ����ֹ״̬������
                dfaEndStates.insert(stateSet.begin(), stateSet.end());
                break;
            }
        }
    }

    // ���� DFA ���󣬲���������ʼ״̬����ֹ״̬��״̬ת�ƹ�ϵ
    DFA* dfa = new DFA(dfaStartStates, dfaEndStates);
    dfa->transitions = dfaTransitions;

    return dfa;
}

void printDFA(DFA* dfa)
{
    cout << "DFA States:" << endl;
    // ���� DFA ��״̬ת��ӳ�䣬���� stateTransitionPair ��һ�� DFA ״̬���ϵ�״̬ת��ӳ���ӳ��
    for (const auto& stateTransitionPair : dfa->transitions)
    {
        // ��ǰ״̬����
        const set<State*>& stateSet = stateTransitionPair.first;
        cout << "State { ";

        // ��ӡ��ǰ״̬�����е�ÿ��״̬
        for (State* state : stateSet)
        {
            cout << state << " ";
        }
        cout << "}" << endl;
    }

    cout << "DFA Transitions:" << endl;

    // �ٴα��� DFA ��״̬ת��ӳ��
    for (const auto& transition : dfa->transitions)
    {
        // ��ʼ״̬����
        const set<State*>& fromStates = transition.first;
        // ���ŵ�Ŀ��״̬���ϵ�ӳ��
        const map<char, set<State*>>& toStates = transition.second;

        // ������ĸ���е��ַ� 'a' �� 'z'�����ÿ���ַ���״̬ת��
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            // ��鵱ǰ�ַ��Ƿ���ת��
            if (toStates.find(symbol) != toStates.end())
            {
                // Ŀ��״̬����
                const set<State*>& nextStateSet = toStates.at(symbol);

                cout << "Transition from { ";

                // ��ӡ��ʼ״̬�����е�ÿ��״̬
                for (State* state : fromStates)
                {
                    cout << state << " ";
                }
                cout << "} on symbol '" << symbol << "' to { ";

                // ��ӡĿ��״̬�����е�ÿ��״̬
                for (State* state : nextStateSet)
                {
                    cout << state << " ";
                }
                cout << "}" << endl;
            }
        }
    }

    cout << "Start States: { ";

    // ��ӡ DFA ����ʼ״̬�����е�ÿ��״̬
    for (State* state : dfa->startStates)
    {
        cout << state << " ";
    }
    cout << "}" << endl;

    cout << "End States: " ;

    // ��ӡ DFA ����ֹ״̬�����е�ÿ��״̬
    for (State* state : dfa->endStates)
    {
        cout << "State { " << state << " }" << endl;
    }
}
// ���������������������һ�����ڼ���״̬���� 'group' ��һ��Ŀ��״̬���� 'target'��
bool containsAll(const set<State*>& group, const set<State*>& target)
{
    // ʹ�� for ѭ������Ŀ��״̬���� 'target' �е�ÿ��״̬ 'state'��
    // ��ѭ���У����Ǽ��״̬ 'state' �Ƿ������״̬���� 'group' �С�
    // ���״̬���ڣ�find() ���صĵ����������� 'group.end()'��
    for (State* state : target)
    {
        // ���״̬ 'state' ��������״̬���� 'group'���򷵻� false����ʾδ����ȫ��Ŀ��״̬��
        if (group.find(state) == group.end())
        {
            return false;
        }
    }
    // ��� for ѭ����ɺ���δ���� false����ʾ״̬���� 'group' ������ 'target' �е�����״̬��
    return true;
}

// ��С��DFA���㷨
DFA* minimizeDFA(DFA* dfa)
{
    // ��ʼ�����飬������ֹ״̬�ͷ���ֹ״̬
    set<set<State*>> P; // ��ǰ���鼯��
    set<State*> nonEndStates; // ����ֹ״̬����
    // ���� DFA ����ֹ״̬����Ϊÿ��״̬����һ����Ԫ�صķ��飬������ӵ� P ��
    for (State* state : dfa->endStates)
    {
        set<State*> endStateGroup;
        endStateGroup.insert(state);
        P.insert(endStateGroup);
    }
    // �ҳ� DFA �ķ���ֹ״̬����������ӵ������ķ����У�Ȼ����Щ������ӵ� P ��
    for (State* state : dfa->startStates)
    {
        if (dfa->endStates.find(state) == dfa->endStates.end())
        {
            nonEndStates.insert(state);
        }
    }

    P.insert(nonEndStates);

    // �����ϲ���ֱ��������ϸ����
    bool changed = true;
    while (changed)
    {
        changed = false;
        set<set<State*>> newP; // ���ڴ洢��һ�ֵķ���

        for (set<State*> group : P)
        {
            // ���ÿ���ַ����״̬�Ƿ���ͬһ����
            map<char, set<State*>> transitionsForGroup;
            for (State* state : group)
            {
                // ���ڵ�ǰ״̬ group �е�ÿ��״̬ state����������ڲ�ͬ�ַ��µ�״̬ת��Ŀ�꣬
                // ������ЩĿ��״̬����洢�� transitionsForGroup �С�
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

            // ��� transitionsForGroup �а��������ͬ�ķ��飬����Ҫ��ֵ�ǰ����
            if (transitionsForGroup.size() > 1)
            {
                // ��������״̬������ת����ͬ���飬��Ҫ��ַ���
                changed = true;
                // �� transitionsForGroup �еĲ�ͬ������ӵ� newP ��
                for (const auto& transition : transitionsForGroup)
                {
                    newP.insert(transition.second);
                }
            }
            else
            {
                // ��� transitionsForGroup ��ֻ����һ�����飬����ǰ���鱣�ֲ���
                newP.insert(group);
            }
        }
        // ���·��鼯�� P Ϊ�µķ��鼯�� newP
        P = newP;
    }

    // ������С��DFA
    set<State*> startStates;
    set<State*> endStates;
    map<set<State*>, map<char, set<State*>>> transitions;
    // ������С����ķ��鼯�� P
    for (set<State*> group : P)
    {
        // �ҳ�������ʼ״̬�ķ��鲢�洢Ϊ startStates
        if (containsAll(group, dfa->startStates))
        {
            startStates = group;
        }
        // �ҳ�������ֹ״̬�ķ��鲢�洢Ϊ endStates
        if (containsAll(group, dfa->endStates))
        {
            endStates.insert(group.begin(), group.end());
        }
        // Ϊÿ���ַ�����״̬ת�ƹ�ϵ�����洢�� transitions ��
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
            // ��� transitionsForSymbol �ǿգ�����洢�� transitions ��
            if (!transitionsForSymbol.empty())
            {
                transitions[group][symbol] = transitionsForSymbol[group];
            }
        }
    }

    // ������С��DFA
    DFA* minimizedDFA = new DFA(startStates, endStates);
    minimizedDFA->transitions = transitions;

    return minimizedDFA;
}

void printMinDFA(DFA* dfa)
{
    cout << "Minimized DFA States:" << endl;
    // ������С���� DFA �е�״̬��״̬ת��
    for (const auto& stateTransitionPair : dfa->transitions)
    {
        const set<State*>& stateSet = stateTransitionPair.first;
        cout << "State { ";
        // �����ǰ״̬���ϵ�����״̬
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
        // ���� DFA ��״̬ת�ƹ�ϵ
        for (char symbol = 'a'; symbol <= 'z'; symbol++)
        {
            if (toStates.find(symbol) != toStates.end())
            {
                const set<State*>& nextStateSet = toStates.at(symbol);

                cout << "Transition from { ";
                // ���״̬ת�Ƶ���ʼ״̬
                for (State* state : fromStates)
                {
                    cout << state << " ";
                }
                cout << "} on symbol '" << symbol << "' to { ";
                // ���״̬ת�Ƶ�Ŀ��״̬
                for (State* state : nextStateSet)
                {
                    cout << state << " ";
                }
                cout << "}" << endl;
            }
        }
    }

    cout << "Minimized DFA Start States: { ";
    // �����С���� DFA ����ʼ״̬
    for (State* state : dfa->startStates)
    {
        cout << state << " ";
    }
    cout << "}" << endl;

    cout << "Minimized DFA End States: " << endl;
    // �����С���� DFA ����ֹ״̬
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
    // ��� NFA
    printNFA(nfa);
    cout << endl;

    cout << "NFA -> DFA" << endl;
    // �� NFA ת��Ϊ DFA
    DFA* dfa = subsetConstruction(nfa);
    // ��� DFA
    printDFA(dfa);
    cout << endl;

    cout << "Minimized DFA" << endl;
    DFA* minDFA = minimizeDFA(dfa);
    printMinDFA(minDFA);
    cout << endl;

    return 0;
}

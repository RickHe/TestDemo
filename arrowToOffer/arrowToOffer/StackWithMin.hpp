//
//  StackWithMin.hpp
//  arrowToOffer
//
//  Created by DaFenQi on 16/11/1.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#ifndef StackWithMin_hpp
#define StackWithMin_hpp

#include <stdio.h>
#include <stack>

using namespace std;

template <typename T>
class StackWithMin {
    stack <T> stack1;
    stack <T> stack2;
    
public:
    bool isEmpty();
    void push(T ele);
    void pop();
    T top();
    T min();
};

template <typename T>
void StackWithMin<T>::push(T ele) {
    if (!isEmpty()) {
        if (ele < stack2.top()) {
            stack2.push(ele);
        } else {
            stack2.push(stack2.top());
        }
    } else {
        stack2.push(ele);
    }
    stack1.push(ele);
}

template <typename T>
bool StackWithMin<T>::isEmpty() {
    return stack1.empty();
}

template <typename T>
void StackWithMin<T>::pop() {
    //assert(isEmpty());
    stack2.pop();
    stack1.pop();
}

template <typename T>
T StackWithMin<T>::top() {
    //assert(isEmpty());
    return stack1.top();
}

template <typename T>
T StackWithMin<T>::min() {
    //assert(isEmpty());
    return stack2.top();
}

#endif /* StackWithMin_hpp */

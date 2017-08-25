//
//  main.cpp
//  arrowToOffer
//
//  Created by DaFenQi on 16/10/31.
//  Copyright © 2016年 DaFenQi. All rights reserved.
//

#include <iostream>
#include "StackWithMin.hpp"
#include <queue>

// 普通链表
typedef struct ListNode {
    int data;
    ListNode *next;
} ListNode;

// 复杂链表
typedef struct ComplexListNode {
    int data;
    ComplexListNode *next;
    ComplexListNode *sibling;
} ComplexListNode;

// 二叉树
typedef struct BinaryTree {
    int data;
    BinaryTree *left;
    BinaryTree *right;
} BinaryTree;

#pragma mark - 链表的逆转
ListNode* reverseList2(ListNode* head)
{
    if(head == NULL || head->next == NULL)
        return head;
    
    ListNode* newHead = reverseList2(head->next);
    head->next->next = head;
    head->next = NULL;
    
    return newHead;
}

void printList(ListNode *list) {
    while (list!= NULL) {
        printf("%d ", list->data);
        list = list->next;
    }
    
    printf("\n");
}

// nonrecursive
ListNode* reverseList(ListNode *phead) {
    if (phead == NULL) {
        return NULL;
    }
    ListNode *pReverseHead = NULL;
    ListNode *preNode = NULL;
    ListNode *currentNode = phead;
    if (phead->next == NULL) {
        return phead;
    }
    while (currentNode != NULL) {
        ListNode *nextNode = currentNode->next;
        if (nextNode == NULL) {
            pReverseHead = currentNode;
        }
        currentNode->next = preNode;
        preNode = currentNode;
        currentNode = nextNode;
    }
    return pReverseHead;
}

void testList() {
    ListNode *phead = new ListNode();
    phead->data = 1;
    
    ListNode *pfirst = new ListNode();
    pfirst->data = 2;
    
    ListNode *pSec = new ListNode();
    pSec->data = 3;
    
    printList(reverseList2(NULL));
    printList(reverseList2(phead));
    
    phead->next = pfirst;
    pfirst->next = pSec;
    
    printList(reverseList2(phead));
}

#pragma mark - 合并链表
ListNode * mergeLists(ListNode *list1, ListNode *list2) {
    if (list1 == NULL) {
        return list2;
    }
    
    if (list2 == NULL) {
        return list1;
    }
    
    ListNode *mergeList = NULL;
    
    if (list1->data > list2->data) {
        mergeList = list2;
        mergeList->next = mergeLists(list1, list2->next);
    } else {
        mergeList = list1;
        mergeList->next = mergeLists(list1->next, list2);
    }
    
    return mergeList;
}

#pragma mark - 二叉树的镜像
void exchangeLeftAndRightValue(BinaryTree *left, BinaryTree *right) {
    if (left == NULL) {
        left = new BinaryTree();
        left = right;
        return;
    }
    
    if (right == NULL) {
        right = new BinaryTree();
        right = left;
        return;
    }
    
    exchangeLeftAndRightValue(left->left, left->right);
    exchangeLeftAndRightValue(right->left, right->right);
    
    BinaryTree *temp = right;
    right = left;
    left = temp;
}

void mirror(BinaryTree *tree) {
    if (tree == NULL ||
        (tree->left == NULL && tree->right == NULL)) {
        return;
    }
    
    exchangeLeftAndRightValue(tree->left, tree->right);
}

void mirrorRecursive(BinaryTree *tree) {
    if (tree == NULL ||
        ((tree->left == NULL) && (tree->right == NULL))) {
        return;
    }
    
    BinaryTree *temp = tree->left;
    tree->left = tree->right;
    tree->right = temp;
    
    if (tree->left != NULL) {
        mirrorRecursive(tree->left);
    }
    
    if (tree->right != NULL) {
        mirrorRecursive(tree->right);
    }
}

#pragma mark - 包含min()函数的栈,且push pop min 时间复杂度为O(1)
// 3    3
// 34   33
// 342  332
// 3427 3322
// pop push min
void testStackWithMin() {
    StackWithMin<int> *stack = new StackWithMin<int>();
    
    stack->push(3);
    stack->push(4);
    stack->push(2);
    stack->push(1);
    
    cout<< stack->min() << endl;
    stack->pop();
    
    cout<< stack->min() << endl;
    stack->pop();
    
    cout<< stack->min() << endl;
    stack->pop();
    
    cout<< stack->min() << endl;
    stack->pop();
    //cout<< stack->min();
}

#pragma mark - 删除重复数字
///// 删除数组中的重复数字
//// 1 2 3 1 2 3 4 5
/// 计数法
int* deleteTheRepeatedNumbers(int *n, int length) {
    if (n == NULL ) {
        return NULL;
    }
    
    if (length <= 1) {
        return n;
    }
    
    int *result = (int *)malloc(length * sizeof(int));//new int[length];
    int repeat[100] = {false};
    int cnt = 0;
    
    for (int i = 0; i < length; i++) {
        if (repeat[n[i]]) {
            // 重复
            continue;
        } else {
            result[cnt++] = n[i];
            repeat[n[i]] = true;
        }
    }
    
    return result;
}

#pragma mark - 一颗树是否包含某树
bool doesTree1HasTree2(BinaryTree *tree1, BinaryTree *tree2) {
    if (tree2 == NULL) {
        return true;
    }
    
    if (tree1 == NULL) {
        return false;
    }
    
    if (tree1->data == tree2->data) {
        return (doesTree1HasTree2(tree1->left, tree2->left)) &&
        (doesTree1HasTree2(tree1->right, tree2->right));
    } else {
        return false;
    }
}

// tree1 是否包含tree2
bool hasTree(BinaryTree *tree1, BinaryTree *tree2) {
    if (tree1 == NULL) {
        return false;
    }
    
    if (tree2 == NULL) {
        return true;
    }
    
    bool result = false;
    
    if (tree1->data == tree2->data) {
        result = doesTree1HasTree2(tree1, tree2);
    } else {
        if (!result) {
            result = hasTree(tree1->right, tree2);
        }
        
        if (!result) {
            result = hasTree(tree2->left, tree2);
        }
    }
    
    return result;
}

#pragma mark - 判断某序列是否为压栈序列的出栈序列 如压栈序列 1,2,3,4,5. 序列 4, 5, 3, 2, 1
// 思路
// 序列++,若序列元素= 栈顶元素入栈,否则压栈1, 2, 3, 4,直到4
// 栈中 1, 2, 3, 4 4 = 栈顶元素 pop
// 1, 2, 3   序列++ 5
// 5不等于栈顶元素, 继续压栈,
// 1, 2, 3, 5, 5= 栈顶元素,出栈,
// 1, 2, 3 序列++, 3 = 栈顶元素出栈
// 1, 2 序列++ 2 = 栈顶元素出栈
// 1 序列++ 1 = 栈顶元素出栈
// 空栈,并且序列遍历over 为成功,否则失败
bool isPopOrder(int *pPush, int *pPop, int length) {
    bool result = false;
    
    if (pPush != NULL &&
        pPop != NULL &&
        length > 0) {
        
        int *pNextPush = pPush;
        int *pNextPop = pPop;
        
        std::stack<int> stackData;
        
        while (pNextPop - pPop < length) {
            
            while (stackData.empty() || *pNextPop != stackData.empty()) {
                
                if (pNextPush - pPush >= length) {
                    break;
                }
                
                stackData.push(*pNextPush);
                pNextPush++;
            }
            
            if (stackData.top() != *pNextPush) {
                break;
            }
            
            stackData.pop();
            pNextPop++;
        }
        
        if (stackData.empty() && pNextPop - pPop == length) {
            result = true;
        }
    }
    
    return result;
}

#pragma mark - 判断一个序列是否为二叉排序树
bool isBinarySortTree(int *a, int length) {
    if (a == NULL || length <= 0) {
        return false;
    }
    
    int i;
    for (i = 0; i < length; i++) {
        if (a[i] > a[length - 1]) {
            break;
        }
    }
    
    int j = i;
    for (j = i ; j < length; j++) {
        if (a[j] < a[length - 1]) {
            return false;
        }
    }
    
    bool left = true;
    if (i > 0) {
        left = isBinarySortTree(a, i);
    }
    
    bool right = true;
    if (i < length) {
        right = isBinarySortTree(a + i, length - i);
    }
    
    return left && right;
}

#pragma mark - 打印二叉树中和为某一值的路径
void findPath(BinaryTree *t, int sum, int &currentSum, std::vector<int>& path) {
    BinaryTree *root = t;
    currentSum += root->data;
    path.push_back(root->data);
    bool isLeaf = (root->left == NULL) && (root->right == NULL);
    
    if (currentSum == sum && isLeaf) {
        std::vector<int>::iterator iter = path.begin();
        for (; iter != path.end(); iter++) {
            std::cout<< *iter << " ";
        }
        std::cout<< std::endl;
    }
    
    if (root->left != NULL) {
        findPath(root->left, sum, currentSum, path);
    }
    
    if (root->right != NULL) {
        findPath(root->right, sum, currentSum, path);
    }
    
    currentSum -= root->data;
    path.pop_back();
}

void printPath(BinaryTree *t, int sum) {
    if (t == NULL) {
        return;
    }
    
    int currentSum = 0;
    std::vector<int> path;
    // 引用
    findPath(t, sum, currentSum, path);
}

#pragma mark - 字符串到整数
static bool stringToIntValid = true;

int stringToInt(const char *str) {
    stringToIntValid = true;
    
    // null
    if (str == NULL) {
        stringToIntValid = false;
        return 0;
    }
    
    // 是否有+-
    bool hasSign = false;
    // + or -
    bool isPostive = true;
    // + -
    if (str[0] == '+') {
        isPostive = true;
        hasSign = true;
    }
    
    if (str[0] == '-') {
        isPostive = false;
        hasSign = true;
    }
    
    if (hasSign) {
        if (strlen(str) > 1) {
             str++;
        } else {
            stringToIntValid = false;
            return 0;
        }
    }
    
    int num = 0;
    while (*str != '\0') {
        if ('0' <= *str && *str <= '9') {
            num = num * 10 + (*str - '0');
            str++;
            if (num > INT_MAX / 10 && *str != '\0') {
                num = 0;
                break;
            }
        } else {
            num = 0;
            break;
        }
    }
    
    if (*str == '\0') {
        stringToIntValid = false;
        if (!isPostive) {
            num = 0 - num;
        }
    }
    
    return num;
}

#pragma mark - 从上往下打印二叉树
void printTree(BinaryTree *bTree) {
    if (bTree == NULL) {
        return;
    }
    
    std::queue<BinaryTree *> queue;
    queue.push(bTree);
    
    while (!queue.empty()) {
        BinaryTree *node = queue.front();
        queue.pop();
        cout<< node->data<< " ";
        if (node->left != NULL) {
            queue.push(node->left);
        }
        
        if (node->right != NULL) {
            queue.push(node->right);
        }
    }
}

#pragma mark - 复制复杂链表
// 思路一:
// 遍历链表,复制节点,使用next连接
// 遍历新链表,对应的sibling指向对应位置的节点,
// 时间复杂度 O(n ^ 2), 空间复杂度O(1)
// 思路二:
// 使用空间换时间
// 遍历链表,复制节点,使用next链接,并且存在哈希表或字典里面
// 遍历新链表,对应的sibling指向对应位置节点,使用哈希表查
// 时间复杂度O(n) , 空间复杂度O(n)
// 思路三
// 遍历节点,复制节点插入复制的节点后面
// sibling 指向对应的被复制节点的next
// 拆分链表

// 插入复制节点
void cloneNodes(ComplexListNode *pHead) {
    ComplexListNode *node = pHead;
    while (node != NULL) {
        ComplexListNode *pCloned = new ComplexListNode();
        pCloned->data = node->data;
        pCloned->next = node->next;
        pCloned->sibling = NULL;
        
        node->next = pCloned;
        node = pCloned->next;
    }
}

// 链接sibling
void connectSiblingNodes(ComplexListNode *pHead) {
    ComplexListNode *pNode = pHead;
    while (pNode != NULL) {
        ComplexListNode *pColoned = pNode->next;
        if (pNode->sibling != NULL) {
            pColoned->sibling = pNode->sibling->next;
        }
        pNode = pColoned->next;
    }
}

ComplexListNode * reconnectNodes(ComplexListNode *pHead) {
    ComplexListNode *pNode = pHead;
    ComplexListNode *pClonedHead = NULL;
    ComplexListNode *pColnedNode = NULL;
    
    if (pNode != NULL) {
        pColnedNode = pClonedHead = pNode->next;
        pNode->next = pColnedNode->next;
        pNode = pNode->next;
    }
    
    while (pNode != NULL) {
        pColnedNode->next = pNode->next;
        pColnedNode = pColnedNode->next;
        pNode->next = pColnedNode->next;
        pNode = pNode->next;
    }
    
    return pClonedHead;
}

ComplexListNode * clone(ComplexListNode *pHead) {
    if (pHead == NULL) {
        return NULL;
    }
    
    cloneNodes(pHead);
    connectSiblingNodes(pHead);
    return reconnectNodes(pHead);
}

#pragma mark - 转换二叉搜索树到排序的双向链表
void convertTree(BinaryTree *pNode, BinaryTree **pLastNodeInList) {
    if (pNode == NULL) {
        return;
    }
    
    BinaryTree *pCurrent = pNode;
    
    if (pCurrent->left != NULL) {
        convertTree(pCurrent->left, pLastNodeInList);
    }
    
    pCurrent->left = *pLastNodeInList;
    
    if (*pLastNodeInList != NULL) {
        (*pLastNodeInList)->right = pCurrent;
    }
    
    *pLastNodeInList = pCurrent;
    
    if (pCurrent->right != NULL) {
        convertTree(pCurrent->right, pLastNodeInList);
    }
}

BinaryTree * convert(BinaryTree *pRoot) {
    if (pRoot == NULL) {
        return NULL;
    }
    BinaryTree *pLastNodeInList = NULL;
    convertTree(pRoot, &pLastNodeInList);
    
    BinaryTree *pHeadOfList = pLastNodeInList;
    while (pHeadOfList != NULL && pHeadOfList->left != NULL) {
        pHeadOfList = pHeadOfList->left;
    }
    return pHeadOfList;
}

#pragma mark - 字符串的所有排列
void permutation(char *pStr, char*pBegin) {
    if (*pBegin == '\0') {
        printf("%s\n", pStr);
    } else {
        for (char *pCh = pBegin; *pCh != '\0'; ++pCh) {
            char temp = *pCh;
            *pCh = *pBegin;
            *pBegin = temp;
            
            permutation(pStr, pBegin + 1);
        }
    }
}

void permutation(char *pStr) {
    if (pStr == NULL) {
        return;
    }
    permutation(pStr, pStr);
}

#pragma mark - 字符的所有组合
void combination(char *pStr, vector<char> &result, int length) {
    if (length == 0) {
        vector<char>::iterator iter = result.begin();
        for (; iter != result.end(); iter++) {
            printf("%c", *iter);
        }
        printf("\n");
        return;
    }
    
    if (*pStr == '\0') {
        return;
    }
    
    result.push_back(*pStr);
    combination(pStr + 1, result, length - 1);
    result.pop_back();
    combination(pStr + 1, result, length);
}

void printCombination(char *pStr) {
    if (pStr == NULL) {
        return;
    }
    
    int length = (int)strlen(pStr);
    for (int i = 1; i <= length; i++) {
        vector<char> result;
        combination(pStr, result, i);
    }
}

#pragma mark - main
int main(int argc, const char * argv[]) {
    BinaryTree *root = new BinaryTree();
    root->data = 8;
    
    BinaryTree *node1 = new BinaryTree();
    node1->data = 6;
    
    BinaryTree *node2 = new BinaryTree();
    node2->data = 10;
    
    BinaryTree *node3 = new BinaryTree();
    node3->data = 5;
    
    BinaryTree *node4 = new BinaryTree();
    node4->data = 7;
    
    BinaryTree *node5 = new BinaryTree();
    node5->data = 9;
    
    BinaryTree *node6 = new BinaryTree();
    node6->data = 11;
    
    root->left = node1;
    root->right = node2;
    
    node1->left = node3;
    //node1->right = node4;
    
    node2->left = node5;
    node2->right = node6;
    
    printTree(root);
    
    // insert code here...
    /*
     int a[10] = {1, 2, 4, 1, 2, 3, 4, 5, 6, 8};
     int *b = deleteTheRepeatedNumbers(a, 10);
     
     for (int i = 0; i < 10; i++) {
     if (b[i]) {
     std::cout<< b[i]<< " ";
     }
     }
     */
    testList();
    testStackWithMin();
    
    // strtoint 测试用例
    std::cout << stringToInt("12312312") << std::endl;
    std::cout << stringToInt("+12312312") << std::endl;
    std::cout << stringToInt("+") << std::endl;
    std::cout << stringToInt("-12312312") << std::endl;
    std::cout << stringToInt("-") << std::endl;
    std::cout << stringToInt("12321dsadas") << std::endl;
    std::cout << stringToInt("12312312312123232132121213") << std::endl;
    
    char *str = new char[4];
    str[0] = 'a';
    str[1] = 'b';
    str[2] = 'c';
    str[3] = 'd';
    //str[4] = 'e';
    //permutation(str);
    printCombination(str);
    
    return 0;
}


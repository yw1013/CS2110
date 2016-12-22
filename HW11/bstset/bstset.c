/**
 * CS 2110 - Fall 2015 - HW11
 * Andrew Wilder
 *
 * Name: YEA WON YOON
 * bstset.c: Complete the functions!
 */

#include <stdlib.h>
#include <stdio.h>
#include "bstset.h"

/* The bnode struct. This struct is not visible to the user of the bstset.
 * Do not modify this in any way or else you will get a zero. You have been
 * warned! As a design paradigm, only this file should know about this struct.
 * Do not add this struct definition to other files.
 */
typedef struct bnode_t {
    struct bnode_t *left;
    struct bnode_t *right;
    void *data;
} node;

/* There should be absolutely no global data here or else you are doing
 * something wrong. This library should work for multiple bst sets!
 *
 * However, you absolutely may add helper functions here if you would like.
 * Several of these functions have simple, elegant recursive solutions.
 */

/**
 * create_node
 *
 * Helper function that creates a node by allocating memory for it on the heap,
 * and initializing any pointers in it to NULL.
 *
 * @param data A void pointer to data the user is adding to the bst set.
 * @return The node
 */
static node *create_node(void *data) {
    // TODO
    node* newN = malloc(sizeof(node));
    if(newN == NULL) {
        return NULL;
    }
    newN->data = data;
    newN->left = NULL;
    newN->right = NULL;
    return newN;
}

/**
 * create_bstset
 *
 * Creates a bst set by allocating memory for it on the heap. Be sure to
 * initialize the size to zero, as well as root to NULL.
 *
 * @return An empty bst set
 */
bstset *create_bstset(void) {
    // TODO
    bstset* newB = malloc(sizeof(bstset));
    if(newB == NULL){
        return NULL;
    }
    newB->root = NULL;
    newB->size = 0;
    return newB;
}

// int add(bstset *bst, void *data, bst_comp comp_func) {
//     // TODO
//     if(bst->size == 0) {
//         bst->root = create_node(data);
//         bst->size = bst->size +1;
//         return 0;
//     } else {
//         node* newN = create_node(data);
//         node* rtN = bst->root;
//         if(comp_func(newN->data, rtN->data) < 0) {
//             if(rtN->left == NULL) {
//                 bst->root->left = newN;
//                 (bst->size)++;
//                 return 0;
//             } else {
//                 bst->root = rtN->left;
//                 return add(bst, data, comp_func);
//             }
//         } else if(comp_func(newN->data, rtN->data) > 0){
//             if(rtN->right == NULL) {
//                 bst->root->right = newN;
//                 (bst->size)++;
//                 return 0;
//             } else {
//                 bst->root = rtN->right;
//                 return add(bst, data, comp_func);
//             }
//         } else if(comp_func(newN->data, rtN->data) == 0) {
//          return 1;
//         } else {
//             return 1;
//         }
//     }
// }

// int addrec(bstset *bst, node *n, void *data, bst_comp comp_func) {
//     node *newN = create_node(data);
//     int comp = comp_func(n->data, data);
//     if (comp == 0) {
//         return 1;
//     } else if (comp > 0) {
//         if(n->left == NULL){
//             n->left = newN;
//             bst->size++;
//             return 0;
//         } else {
//             return addrec(bst, n->left, data, comp_func);
//         }
//     } else if (comp < 0) {
//         if(n->right == NULL) {
//             n->right = newN;
//             bst->size++;
//             return 0;
//         } else {
//             return addrec(bst, n->right, data, comp_func);
//         }
//     }
//     return 0;
// }

// int add(bstset *bst, void *data, bst_comp comp_func) {
//     if(bst->size ==0) {
//         bst->root = create_node(data);
//         bst->size++;
//         return 0;
//     } else {
//         return addrec(bst, bst->root, data, comp_func);
//     }
// }

int addrec(bstset *bst, node *a, void *data, bst_comp comp_func) {
    int comp = comp_func(a->data, data);
    if (comp == 0) {
        return 1;
    } else if (comp > 0) {
        if(a->left == NULL){
            a->left = create_node(data);
            bst->size++;
            return 0;
        } else {
            return addrec(bst, a->left, data, comp_func);
        }
    } else if (comp < 0) {
        if(a->right == NULL) {
            a->right = create_node(data);
            bst->size++;
            return 0;
        } else {
            return addrec(bst, a->right, data, comp_func);
        }
    }
    return 0;
}

/**
 * add
 *
 * Adds the data to the bst set in the appropriate sorted location.
 * Use comp_func on data, as well as the data contained in a node to determine
 * what to do. The specification for comp_func is as follows:
 *   comp_func(data1, data2)
 *     data1 > data2: returns a positive number
 *     data1 < data2: returns a negative number
 *     data1 = data2: returns zero
 * If the data we are trying to add is already in the bst set, do not modify
 * the bst set.
 *
 * @param bst The bst set we are adding to.
 * @param data The data we are adding to the bst set.
 * @param comp_func The comparison function for two pieces of data.
 * @return 0 if the data was added, 1 if the data was already in the bst set.
 */
int add(bstset *bst, void *data, bst_comp comp_func) {
    if(bst->size == 0) {
        bst->root = create_node(data);
        bst->size++;
        return 0;
    } else {
        return addrec(bst, bst->root, data, comp_func);
    }
}

/**
 * min
 *
 * Gets the minimum element of the bst set.
 * Recall that bst structures are such that the value to the left of the
 * current node is less than the current node. This means that the minimum
 * value should be contained all the way down the left branch of the bst set.
 *
 * @param bst The bst set.
 * @return The minimum element, or NULL if nothing in the bst set
 */
void *min(bstset *bst) {
    // TODO
    if (bst->size == 0) {
        return NULL;
    } else {
        node* rtN = bst->root;
        while (rtN->left != NULL) {
            rtN = rtN->left;
        }
        return rtN->data;
    }
}

// node *minHelper(node *mNode) {
//  if (mNode->left== NULL) {
//      return mNode;
//  }
//  return minHelper(mNode->left);
// }

// void *min(bstset *bst) {
//  if (bst->root == NULL) {
//      return NULL;
//  } else {
//      return minHelper(bst->root);
//  }
// }

/**
 * max
 *
 * Gets the maximum element of the bst set.
 * Recall that bst structures are such that the value to the right of the
 * current node is greater than the current node. This means that the maximum
 * value should be contained all the way down the right branch of the bst set.
 *
 * @param bst The bst set.
 * @return The maximum element, or NULL if nothing in the bst set
 */
void *max(bstset *bst) {
    // TODO
    if (bst->size == 0) {
        return NULL;
    } else {
        node* rtN = bst->root;
        while (rtN->right != NULL) {
            rtN = rtN->right;
        }
        return rtN->data;
    }
}

// int contains(bstset *bst, void *data, bst_comp comp_func) {
//     // TODO
//     if (bst == NULL) {
//         return 0;
//     } else {
//         node* rtN = bst->root;
//         if(comp_func(data, rtN->data) < 0) {
//             if(rtN->left == NULL) {
//                 if(comp_func(data, rtN->data) == 0) {
//                     return 1;
//                 } else {
//                     return 0;
//                 }
//             } else {
//                 bst->root = rtN->left;
//                 return contains(bst, data, comp_func);
//             }
//         } else if(comp_func(data, rtN->data) > 0){
//             if(rtN->right == NULL) {
//                 if(comp_func(data, rtN->data) == 0) {
//                     return 1;
//                 } else {
//                     return 0;
//                 }
//             } else {
//                 bst->root = rtN->right;
//                 return contains(bst, data, comp_func);
//             }
//         } else {
//             return 1;
//         }
//     }
// }

int contRec(node *n, node *a, void *data, bst_comp comp_func) {
    int comp = comp_func(n->data, a->data);
    if (comp == 0) {
        free(a);
        return 1;
    }
    if (comp > 0) {
        if((n->left) == NULL){
            free(a);
            return 0;
        } else{
            return contRec(n->left, a, data, comp_func);
        }
    } else if (comp < 0) {
        if((n->right) == NULL) {
            free(a);
            return 0;
        } else {
            return contRec(n->right, a, data, comp_func);
        }
    }
    return 1;
}

/**
 * contains
 *
 * Tells if the given data is contained in the bst set.
 * Use comp_func to determine if the given data is equal to something in the
 * bst set. You should not traverse the entire bst to find the data, because it
 * is a sorted structure! Any node should only be visited once in trying to
 * find the data.
 *
 * @param bst The bst set.
 * @param comp_func The comparison function for two pieces of data.
 * @return 1 if the data was in the bst set, 0 otherwise.
 */
int contains(bstset *bst, void *data, bst_comp comp_func) {
    if (bst->size == 0) {
        return 0;
    } else {
        return contRec(bst->root, create_node(data), data, comp_func);
    }
}

// int contains(bstset *bst, void *data, bst_comp comp_func) {
//     // TODO
//  if(bst->size == 0) {
//      return 0;
//  } else {
//      node *newN = create_node(data);
//      node *rtN = bst->root;
//      int comp = comp_func(newN->data, rtN->data);
//      while(comp != 0) {
//          if {
//              if(rtN->right == NULL) {
//                  return 0;
//              } else {
//                  rtN = rtN->right;
//                  comp = comp_func(newN->data, rtN->data);
//              }
//          }
//          else(comp < 0) {
//              if(rtN->left == NULL) {
//                  return 0;
//              } else {
//                  rtN = rtN->left;
//                  comp = comp_func(newN->data, rtN->data);
//              }
//          } 
//      }
//      return 1;
//  }
// }

void travRec(node*a, bst_op do_func) {
    if(a != NULL) {
        travRec(a->left, do_func) ;
        do_func(a->data);
        travRec(a->right, do_func);
    }
}

/**
 * traverse
 *
 * Do something to each piece of data in the bst.
 * The traversal method you should use is "in-order" traversal:
 *   Recurse left (if there is a left)
 *   Do something to current node's data
 *   Recurse right (if there is a right)
 *
 * The effect of processing the data is in this order:
 *       _4_
 *      /   \
 *     2     6
 *    / \   / \
 *   1   3 5   7
 *
 * @param bst The bst set.
 * @param do_func The function to perform on each piece of data.
 */
void traverse(bstset *bst, bst_op do_func) {
    // TODO
    travRec(bst->root, do_func);
    
}

void destRec(node*a, bst_op free_func) {
    if(a != NULL) {
        destRec(a->left, free_func) ;
        destRec(a->right, free_func);
        free_func(a->data);
        free(a);
    }
}

/**
 * destroy
 *
 * Destroy the bst set. Everything in the bst set including bstset structure,
 * nodes and data should all be freed from the heap.
 * Since the only one who knows how to free the data is the user, you must use
 * free_func (which is written by the user) to free the data, instead of
 * regular free. However, regular free will suffice for the bst structure and
 * nodes since they were created with malloc.
 *
 * @param bst The bst set.
 * @param free_func The function that the user created to free the data.
 */
void destroy(bstset *bst, bst_op free_func) {
    // TODO
    // node* rtN = bst->root;
    // if(rtN != NULL) {
    //  bst->root = rtN->left;
    //  destroy(bst, free_func);
    //  free_func(rtN->data);
    //  bst->root = rtN->right;
    //  destroy(bst, free_func);
    //  // bst->size = 0;
    //  // bst->root = NULL;
    //  free(bst);
    // }
    destRec(bst->root, free_func);
    free(bst);
}

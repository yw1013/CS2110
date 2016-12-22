import java.util.Collection;
import java.util.List;
import java.util.ArrayList;
import java.util.NoSuchElementException;
import java.util.Queue;
import java.util.LinkedList;

public class BST<T extends Comparable<? super T>> implements BSTInterface<T> {
    // DO NOT ADD OR MODIFY INSTANCE VARIABLES.
    private BSTNode<T> root;
    private int size;

    /**
     * A no argument constructor that should initialize an empty BST
     */
    public BST() {
        root = null;
        size = 0;
    } 

    /**
     * Initializes the BST with the data in the Collection. The data in the BST
     * should be added in the same order it is in the Collection.
     *
     * @param data the data to add to the tree
     * @throws java.lang.IllegalArgumentException if data or any element
     * in data is null
     */
    public BST(Collection<T> data) {
        if (data == null) {
            throw new IllegalArgumentException("Data is null");
        } else {
            for (T element: data) {
                add(element);
            }
        }
    }

    @Override
    public void add(T data) {
        if (data == null) {
            throw new IllegalArgumentException("Data is null");
        }
        if (root == null && size == 0) {
            root = new BSTNode<T>(data);
            size++;
        } else {
            addHelp(data, root);
        }
    }
    
    private void addHelp(T data, BSTNode<T> node) {
        if (data.compareTo(node.getData()) < 0) {
            if (node.getLeft() == null) {
                node.setLeft(new BSTNode<T> (data));
                size++;
            } else {
                addHelp(data, node.getLeft());
            }
        } else  if (data.compareTo(node.getData()) > 0) {
            if (node.getRight() == null) {
                node.setRight(new BSTNode<T> (data));
                size++;
            } else {
                addHelp(data, node.getRight());
            }
        }
    }

    @Override
    public T remove(T data) {
        if (data == null) {
            throw new IllegalArgumentException("Data is null");
        } else if (size == 0) {
            throw new NoSuchElementException("Element does not exist");
        } else {
            return removeHelp(data, root);
        }
    }
    
    private T removeHelp(T data, BSTNode<T> node) {
        T delete = null;
        if (data.equals(node.getData())) {
            if (node.getRight() == null && node.getLeft() == null) {
                delete = node.getData();
                size--;
            } else if (node.getLeft() == null) {
                delete = node.getData();
                size--;
            } else if (node.getRight() == null) {
                delete = node.getData();
                size--;
            } else {
                size--;
                return predecessor(node);
            }
        } else {
            if (data.compareTo(node.getData()) < 0) {
                if (node.getLeft() == null) {
                    throw new NoSuchElementException("Element does not exist.");
                } else {
                    return removeHelp(data, node.getLeft());
                }
            } else if (data.compareTo(node.getData()) > 0) {
                if (node.getRight() == null) {
                    throw new NoSuchElementException("Element does not exist.");
                } else {
                    return removeHelp(data, node.getRight());
                }
            }
        }
        return delete;
    }
    
    private T predecessor(BSTNode<T> node) {
        if (node.getRight() == null) {
            return node.getData();
        } else {
            return predecessor(node.getRight());
        }
    }

    @Override
    public T get(T data) {
        if (data == null) {
            throw new IllegalArgumentException("Data is null");
        } else if (size == 0) {
            throw new NoSuchElementException("Element does not exist");
        } else {
             return getHelp(data, root);
        }
    }
    
    private T getHelp(T data, BSTNode<T> node) {
        T found = null;
        if (data.equals(node.getData())) {
            found = node.getData();
        } else {
            if (data.compareTo(node.getData()) < 0) {
                if (node.getLeft() == null) {
                    throw new NoSuchElementException("Element doesn't exist");
                } else {
                    return getHelp(data, node.getLeft());
                }
            } else if (data.compareTo(node.getData()) > 0) {
                if (node.getRight() == null) {
                    throw new NoSuchElementException("Element doesn't exist");
                } else {
                    return getHelp(data, node.getRight());
                }
            }
        }
        return found;
    }

    @Override
    public boolean contains(T data) {
        if (data == null) {
            throw new IllegalArgumentException("Data is null");
        } else {
            return containsHelp(data, root);
        }
    }
    
    private boolean containsHelp(T data, BSTNode<T> node) {
        boolean found = false;
        if (size == 0) {
            return found;
        }
        if (data.equals(node.getData())) {
            found = true;
        } else {
            if (data.compareTo(node.getData()) < 0) {
                if (node.getLeft() == null) {
                    return found;
                } else {
                    return containsHelp(data, node.getLeft());
                }
            } else if (data.compareTo(node.getData()) > 0) {
                if (node.getRight() == null) {
                    return found;
                } else {
                    return containsHelp(data, node.getRight());
                }
            }
        }
        return found;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public List<T> preorder() {
        List<T> list = new ArrayList<T>();
        preorderHelp(list, root);
        return list;
    }
    
    private void preorderHelp(List<T> list, BSTNode<T> node) {
        if (node != null) {
            list.add(node.getData());
            preorderHelp(list, node.getLeft());
            preorderHelp(list, node.getRight());
        }
    }

    @Override
    public List<T> postorder() {
        List<T> list = new ArrayList<T>();
        postorderHelp(list, root);
        return list;
    }
    
    private void postorderHelp(List<T> list, BSTNode<T> node) {
        if (node != null) {
            postorderHelp(list, node.getLeft());
            postorderHelp(list, node.getRight());
            list.add(node.getData());
        }
    }

    @Override
    public List<T> inorder() {
        List<T> list = new ArrayList<T>();
        inorderHelp(list, root);
        return list;
    }
    
    private void inorderHelp(List<T> list,BSTNode<T> node) {
        if (node != null) {
            inorderHelp(list, node.getLeft());
            list.add(node.getData());
            inorderHelp(list, node.getRight());
        }
    }

    @Override
    public List<T> levelorder() {
        List<T> list = new ArrayList<T>();
        levelorderHelp(list, root);
        return list;
    }
    
    private void levelorderHelp(List<T> list, BSTNode<T> node) {
        Queue<BSTNode<T>> nodequeue = new LinkedList<BSTNode<T>>();
        if (node != null) {
            nodequeue.add(node);
        }
        while (!nodequeue.isEmpty()) {
            BSTNode<T> next = nodequeue.remove();
            list.add(next.getData());
            if (next.getLeft() != null) {
                nodequeue.add(next.getLeft());
            }
            if (next.getRight() != null) {
                nodequeue.add(next.getRight());
            }
        }
    }

    @Override
    public void clear() {
        root = null;
        size = 0;
    }

    @Override
    public int height() {
        if (size == 0) {
            return -1;
        } else {
            return heightHelp(root);
        }
    }
    
    private int heightHelp(BSTNode<T> node) {
        if (node == null) {
            return -1;
        } else {
            int height = Math.max(heightHelp(node.getLeft()),
                    heightHelp(node.getRight()));
            height = height + 1;
            return height;
        }
        
    }

    /**
     * THIS METHOD IS ONLY FOR TESTING PURPOSES.
     * DO NOT USE IT IN YOUR CODE
     * DO NOT CHANGE THIS METHOD
     *
     * @return the root of the tree
     */
    public BSTNode<T> getRoot() {
        return root;
    }
}
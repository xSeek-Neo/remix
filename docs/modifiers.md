# Solidity 变量与函数修饰符汇总

## 一、变量修饰符

### 1. 可见性修饰符（Visibility）

| 修饰符 | 含义 | 可见范围 |
|--------|------|----------|
| `public` | 公开 | 合约内、继承合约、外部调用（自动生成 getter） |
| `private` | 私有 | 仅当前合约 |
| `internal` | 内部 | 当前合约 + 继承合约 |
| 无修饰符 | 默认 | 等同于 `internal` |

```solidity
uint public count;      // 外部可读，自动生成 getter
uint private secret;    // 仅本合约
uint internal balance;  // 本合约 + 子合约
```

### 2. 常量修饰符

| 修饰符 | 含义 | Gas |
|--------|------|-----|
| `constant` | 编译期常量 | 不占 storage，直接内联 |
| `immutable` | 构造时赋值一次 | 占用 storage，但比普通变量便宜 |

```solidity
uint public constant MAX_SUPPLY = 1000000;  // 必须在声明时赋值
address public immutable owner;             // 可在 constructor 中赋值
```

---

## 二、函数修饰符

### 1. 可见性修饰符

| 修饰符 | 含义 | 调用方式 |
|--------|------|----------|
| `public` | 公开 | 内部、外部均可，自动生成外部接口 |
| `external` | 外部 | 只能外部调用，内部用 `this.func()` |
| `internal` | 内部 | 本合约 + 继承合约 |
| `private` | 私有 | 仅本合约 |

```solidity
function inc() external { }   // 推荐：外部调用，gas 更省
function inc() public { }     // 内部、外部都能调
function _helper() internal { }
function _secret() private { }
```

### 2. 状态可变性修饰符（State Mutability）

| 修饰符 | 含义 | 可读状态 | 可写状态 |
|--------|------|----------|----------|
| 无 | 普通函数 | ✅ | ✅ |
| `view` | 只读 | ✅ | ❌ |
| `pure` | 纯计算 | ❌ | ❌ |

```solidity
function getCount() external view returns (uint) {
    return count;  // 可读状态变量
}

function add(uint x, uint y) external pure returns (uint) {
    return x + y;  // 不读不写状态
}
```

### 3. 特殊修饰符

| 修饰符 | 含义 |
|--------|------|
| `payable` | 可接收 ETH，可访问 `msg.value` |
| `virtual` | 可被继承合约 `override` |
| `override` | 重写父合约中的 `virtual` 函数 |

```solidity
function deposit() external payable {
    // msg.value 可用
}

function inc() external virtual { }

contract Child is Parent {
    function inc() external override { }
}
```

---

## 三、修饰符组合示例

```solidity
// 变量
uint public constant FEE = 100;
address public immutable deployer;

// 函数
function getBalance() external view returns (uint);     // 只读
function add(uint a, uint b) external pure returns (uint);  // 纯计算
function deposit() external payable;                    // 可收 ETH
function inc() external virtual;                        // 可被重写
```

---

## 四、常见用法建议

1. **变量**：能用 `constant` 或 `immutable` 就用，节省 gas。
2. **函数**：外部入口用 `external`，内部辅助用 `internal`。
3. **只读逻辑**：不写状态用 `view`，不读状态用 `pure`。
4. **收 ETH**：必须加 `payable`，否则无法接收 ETH。

# Comment

Per-entity reference for the `Comment` GraphQL type. Generated from `apidash/internal/graph/schemas/*.graphql` — regenerate via `task skill:gen`.

## Object type

_Defined in `ent.graphql`._

```graphql
type Comment implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  commentableID: String
  commentableType: String
  authorUserID: String
  authorAgentID: String
  body: String!
  editedAt: Time
}
```

## Create input

```graphql
input CreateCommentInput {
  workspaceID: String
  commentableID: String
  commentableType: String
  authorUserID: String
  authorAgentID: String
  body: String!
  editedAt: Time
}
```

## Update input

```graphql
input UpdateCommentInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  commentableID: String
  clearCommentableID: Boolean
  commentableType: String
  clearCommentableType: Boolean
  authorUserID: String
  clearAuthorUserID: Boolean
  authorAgentID: String
  clearAuthorAgentID: Boolean
  body: String
  editedAt: Time
  clearEditedAt: Boolean
}
```

## Where filter (top-level connection)

```graphql
input CommentWhereInput {
  not: CommentWhereInput
  and: [CommentWhereInput!]
  or: [CommentWhereInput!]
  """
  id field predicates
  """
  id: ID
  idNEQ: ID
  idIn: [ID!]
  idNotIn: [ID!]
  idGT: ID
  idGTE: ID
  idLT: ID
  idLTE: ID
  idEqualFold: ID
  idContainsFold: ID
  """
  workspace_id field predicates
  """
  workspaceID: String
  workspaceIDNEQ: String
  workspaceIDIn: [String!]
  workspaceIDNotIn: [String!]
  workspaceIDGT: String
  workspaceIDGTE: String
  workspaceIDLT: String
  workspaceIDLTE: String
  workspaceIDContains: String
  workspaceIDHasPrefix: String
  workspaceIDHasSuffix: String
  workspaceIDIsNil: Boolean
  workspaceIDNotNil: Boolean
  workspaceIDEqualFold: String
  workspaceIDContainsFold: String
  """
  created_at field predicates
  """
  createdAt: Time
  createdAtNEQ: Time
  createdAtIn: [Time!]
  createdAtNotIn: [Time!]
  createdAtGT: Time
  createdAtGTE: Time
  createdAtLT: Time
  createdAtLTE: Time
  createdAtIsNil: Boolean
  createdAtNotNil: Boolean
  """
  updated_at field predicates
  """
  updatedAt: Time
  updatedAtNEQ: Time
  updatedAtIn: [Time!]
  updatedAtNotIn: [Time!]
  updatedAtGT: Time
  updatedAtGTE: Time
  updatedAtLT: Time
  updatedAtLTE: Time
  updatedAtIsNil: Boolean
  updatedAtNotNil: Boolean
  """
  commentable_id field predicates
  """
  commentableID: String
  commentableIDNEQ: String
  commentableIDIn: [String!]
  commentableIDNotIn: [String!]
  commentableIDGT: String
  commentableIDGTE: String
  commentableIDLT: String
  commentableIDLTE: String
  commentableIDContains: String
  commentableIDHasPrefix: String
  commentableIDHasSuffix: String
  commentableIDIsNil: Boolean
  commentableIDNotNil: Boolean
  commentableIDEqualFold: String
  commentableIDContainsFold: String
  """
  commentable_type field predicates
  """
  commentableType: String
  commentableTypeNEQ: String
  commentableTypeIn: [String!]
  commentableTypeNotIn: [String!]
  commentableTypeGT: String
  commentableTypeGTE: String
  commentableTypeLT: String
  commentableTypeLTE: String
  commentableTypeContains: String
  commentableTypeHasPrefix: String
  commentableTypeHasSuffix: String
  commentableTypeIsNil: Boolean
  commentableTypeNotNil: Boolean
  commentableTypeEqualFold: String
  commentableTypeContainsFold: String
  """
  author_user_id field predicates
  """
  authorUserID: String
  authorUserIDNEQ: String
  authorUserIDIn: [String!]
  authorUserIDNotIn: [String!]
  authorUserIDGT: String
  authorUserIDGTE: String
  authorUserIDLT: String
  authorUserIDLTE: String
  authorUserIDContains: String
  authorUserIDHasPrefix: String
  authorUserIDHasSuffix: String
  authorUserIDIsNil: Boolean
  authorUserIDNotNil: Boolean
  authorUserIDEqualFold: String
  authorUserIDContainsFold: String
  """
  author_agent_id field predicates
  """
  authorAgentID: String
  authorAgentIDNEQ: String
  authorAgentIDIn: [String!]
  authorAgentIDNotIn: [String!]
  authorAgentIDGT: String
  authorAgentIDGTE: String
  authorAgentIDLT: String
  authorAgentIDLTE: String
  authorAgentIDContains: String
  authorAgentIDHasPrefix: String
  authorAgentIDHasSuffix: String
  authorAgentIDIsNil: Boolean
  authorAgentIDNotNil: Boolean
  authorAgentIDEqualFold: String
  authorAgentIDContainsFold: String
  """
  body field predicates
  """
  body: String
  bodyNEQ: String
  bodyIn: [String!]
  bodyNotIn: [String!]
  bodyGT: String
  bodyGTE: String
  bodyLT: String
  bodyLTE: String
  bodyContains: String
  bodyHasPrefix: String
  bodyHasSuffix: String
  bodyEqualFold: String
  bodyContainsFold: String
  """
  edited_at field predicates
  """
  editedAt: Time
  editedAtNEQ: Time
  editedAtIn: [Time!]
  editedAtNotIn: [Time!]
  editedAtGT: Time
  editedAtGTE: Time
  editedAtLT: Time
  editedAtLTE: Time
  editedAtIsNil: Boolean
  editedAtNotNil: Boolean
}
```

## Enums used by this entity

```graphql
enum CommentableType {
  TASK
  SPEC
  PLAN
  DECISION
  MEMORY
}
```

## Related queries (1)

```graphql
  comments(
    """
    Returns the elements in the list that come after the specified cursor.
    """
    after: Cursor
    """
    Returns the first _n_ elements from the list.
    """
    first: Int
    """
    Returns the elements in the list that come before the specified cursor.
    """
    before: Cursor
    """
    Returns the last _n_ elements from the list.
    """
    last: Int
    """
    Ordering options for Comments returned from the connection.
    """
    orderBy: [CommentOrder!]
    """
    Filtering options for Comments returned from the connection.
    """
    where: CommentWhereInput
  ): CommentConnection!
```

## Related mutations (2)

```graphql
  createComment(commentableType: CommentableType!, commentableID: ID!, body: String!, authorUserID: ID, authorAgentID: ID): Comment!
  updateComment(id: ID!, body: String!): Comment!
```

---

See also: [`../API.md`](../API.md) for the flat reference · [`../SKILL.md`](../SKILL.md) for the agent operating manual · [`../playbooks/`](../playbooks/) for end-to-end workflows.

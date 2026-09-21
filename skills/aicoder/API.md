# API.md — exhaustive GraphQL surface

Auto-generated reference of every field, input, enum, and object type in the aicoder GraphQL schema. Source: `modules/apidash/internal/graph/schemas/*.graphql`. Regenerate with `task skill:gen`.

**Endpoint:** `POST /api/dash/query` · **Auth:** see [`SKILL.md`](./SKILL.md) → Auth (user API key via `task aicoder:apikey:create` · session JWT · `X-Internal-Key`).

**Discovery:** the SDL fragments are the source of truth. Live introspection (`{ __schema { … } }`) may be disabled on prod-mode deployments — fall back to this file.

**Per-entity pages** for everything writable live in [`entities/`](./entities/).

---

## Queries (by SDL fragment)

### ent.graphql (39)

```graphql
  """
  Fetches an object given its ID.
  """
  node(
    """
    ID of the object.
    """
    id: ID!
  ): Node
  """
  Lookup nodes by a list of IDs.
  """
  nodes(
    """
    The list of node IDs.
    """
    ids: [ID!]!
  ): [Node]!
  activities(
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
    Ordering options for Activities returned from the connection.
    """
    orderBy: [ActivityOrder!]
    """
    Filtering options for Activities returned from the connection.
    """
    where: ActivityWhereInput
  ): ActivityConnection!
  agents(
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
    Ordering options for Agents returned from the connection.
    """
    orderBy: [AgentOrder!]
    """
    Filtering options for Agents returned from the connection.
    """
    where: AgentWhereInput
  ): AgentConnection!
  areas(
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
    Ordering options for Areas returned from the connection.
    """
    orderBy: [AreaOrder!]
    """
    Filtering options for Areas returned from the connection.
    """
    where: AreaWhereInput
  ): AreaConnection!
  attachments(
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
    Ordering options for Attachments returned from the connection.
    """
    orderBy: [AttachmentOrder!]
    """
    Filtering options for Attachments returned from the connection.
    """
    where: AttachmentWhereInput
  ): AttachmentConnection!
  boards(
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
    Ordering options for Boards returned from the connection.
    """
    orderBy: [BoardOrder!]
    """
    Filtering options for Boards returned from the connection.
    """
    where: BoardWhereInput
  ): BoardConnection!
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
  decisions(
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
    Ordering options for Decisions returned from the connection.
    """
    orderBy: [DecisionOrder!]
    """
    Filtering options for Decisions returned from the connection.
    """
    where: DecisionWhereInput
  ): DecisionConnection!
  designations(
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
    Ordering options for Designations returned from the connection.
    """
    orderBy: [DesignationOrder!]
    """
    Filtering options for Designations returned from the connection.
    """
    where: DesignationWhereInput
  ): DesignationConnection!
  gates(
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
    Ordering options for Gates returned from the connection.
    """
    orderBy: [GateOrder!]
    """
    Filtering options for Gates returned from the connection.
    """
    where: GateWhereInput
  ): GateConnection!
  ideas(
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
    Ordering options for Ideas returned from the connection.
    """
    orderBy: [IdeaOrder!]
    """
    Filtering options for Ideas returned from the connection.
    """
    where: IdeaWhereInput
  ): IdeaConnection!
  labels(
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
    Ordering options for Labels returned from the connection.
    """
    orderBy: [LabelOrder!]
    """
    Filtering options for Labels returned from the connection.
    """
    where: LabelWhereInput
  ): LabelConnection!
  listViews(
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
    Ordering options for ListViews returned from the connection.
    """
    orderBy: [ListViewOrder!]
    """
    Filtering options for ListViews returned from the connection.
    """
    where: ListViewWhereInput
  ): ListViewConnection!
  listViewExcludes(
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
    Ordering options for ListViewExcludes returned from the connection.
    """
    orderBy: [ListViewExcludeOrder!]
    """
    Filtering options for ListViewExcludes returned from the connection.
    """
    where: ListViewExcludeWhereInput
  ): ListViewExcludeConnection!
  listViewIncludes(
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
    Ordering options for ListViewIncludes returned from the connection.
    """
    orderBy: [ListViewIncludeOrder!]
    """
    Filtering options for ListViewIncludes returned from the connection.
    """
    where: ListViewIncludeWhereInput
  ): ListViewIncludeConnection!
  memories(
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
    Ordering options for Memories returned from the connection.
    """
    orderBy: [MemoryOrder!]
    """
    Filtering options for Memories returned from the connection.
    """
    where: MemoryWhereInput
  ): MemoryConnection!
  notifications(
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
    Ordering options for Notifications returned from the connection.
    """
    orderBy: [NotificationOrder!]
    """
    Filtering options for Notifications returned from the connection.
    """
    where: NotificationWhereInput
  ): NotificationConnection!
  plans(
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
    Ordering options for Plans returned from the connection.
    """
    orderBy: [PlanOrder!]
    """
    Filtering options for Plans returned from the connection.
    """
    where: PlanWhereInput
  ): PlanConnection!
  projects(
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
    Ordering options for Projects returned from the connection.
    """
    orderBy: [ProjectOrder!]
    """
    Filtering options for Projects returned from the connection.
    """
    where: ProjectWhereInput
  ): ProjectConnection!
  projectDirectories(
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
    Ordering options for ProjectDirectories returned from the connection.
    """
    orderBy: [ProjectDirectoryOrder!]
    """
    Filtering options for ProjectDirectories returned from the connection.
    """
    where: ProjectDirectoryWhereInput
  ): ProjectDirectoryConnection!
  projectMembers(
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
    Ordering options for ProjectMembers returned from the connection.
    """
    orderBy: [ProjectMemberOrder!]
    """
    Filtering options for ProjectMembers returned from the connection.
    """
    where: ProjectMemberWhereInput
  ): ProjectMemberConnection!
  reviews(
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
    Ordering options for Reviews returned from the connection.
    """
    orderBy: [ReviewOrder!]
    """
    Filtering options for Reviews returned from the connection.
    """
    where: ReviewWhereInput
  ): ReviewConnection!
  runs(
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
    Ordering options for Runs returned from the connection.
    """
    orderBy: [RunOrder!]
    """
    Filtering options for Runs returned from the connection.
    """
    where: RunWhereInput
  ): RunConnection!
  runSteps(
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
    Ordering options for RunSteps returned from the connection.
    """
    orderBy: [RunStepOrder!]
    """
    Filtering options for RunSteps returned from the connection.
    """
    where: RunStepWhereInput
  ): RunStepConnection!
  scratches(
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
    Ordering options for Scratches returned from the connection.
    """
    orderBy: [ScratchOrder!]
    """
    Filtering options for Scratches returned from the connection.
    """
    where: ScratchWhereInput
  ): ScratchConnection!
  sources(
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
    Ordering options for Sources returned from the connection.
    """
    orderBy: [SourceOrder!]
    """
    Filtering options for Sources returned from the connection.
    """
    where: SourceWhereInput
  ): SourceConnection!
  specs(
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
    Ordering options for Specs returned from the connection.
    """
    orderBy: [SpecOrder!]
    """
    Filtering options for Specs returned from the connection.
    """
    where: SpecWhereInput
  ): SpecConnection!
  tags(
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
    Ordering options for Tags returned from the connection.
    """
    orderBy: [TagOrder!]
    """
    Filtering options for Tags returned from the connection.
    """
    where: TagWhereInput
  ): TagConnection!
  taggables(
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
    Ordering options for Taggables returned from the connection.
    """
    orderBy: [TaggableOrder!]
    """
    Filtering options for Taggables returned from the connection.
    """
    where: TaggableWhereInput
  ): TaggableConnection!
  tasks(
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
    Ordering options for Tasks returned from the connection.
    """
    orderBy: [TaskOrder!]
    """
    Filtering options for Tasks returned from the connection.
    """
    where: TaskWhereInput
  ): TaskConnection!
  taskAssignees(
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
    Ordering options for TaskAssignees returned from the connection.
    """
    orderBy: [TaskAssigneeOrder!]
    """
    Filtering options for TaskAssignees returned from the connection.
    """
    where: TaskAssigneeWhereInput
  ): TaskAssigneeConnection!
  taskLinks(
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
    Ordering options for TaskLinks returned from the connection.
    """
    orderBy: [TaskLinkOrder!]
    """
    Filtering options for TaskLinks returned from the connection.
    """
    where: TaskLinkWhereInput
  ): TaskLinkConnection!
  taskLists(
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
    Ordering options for TaskLists returned from the connection.
    """
    orderBy: [TaskListOrder!]
    """
    Filtering options for TaskLists returned from the connection.
    """
    where: TaskListWhereInput
  ): TaskListConnection!
  taskTemplates(
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
    Ordering options for TaskTemplates returned from the connection.
    """
    orderBy: [TaskTemplateOrder!]
    """
    Filtering options for TaskTemplates returned from the connection.
    """
    where: TaskTemplateWhereInput
  ): TaskTemplateConnection!
  users(
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
    Ordering options for Users returned from the connection.
    """
    orderBy: [UserOrder!]
    """
    Filtering options for Users returned from the connection.
    """
    where: UserWhereInput
  ): UserConnection!
  userSSHKeys(
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
    Ordering options for UserSshKeys returned from the connection.
    """
    orderBy: [UserSshKeyOrder!]
    """
    Filtering options for UserSshKeys returned from the connection.
    """
    where: UserSshKeyWhereInput
  ): UserSshKeyConnection!
  workspaceLayouts(
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
    Ordering options for WorkspaceLayouts returned from the connection.
    """
    orderBy: [WorkspaceLayoutOrder!]
    """
    Filtering options for WorkspaceLayouts returned from the connection.
    """
    where: WorkspaceLayoutWhereInput
  ): WorkspaceLayoutConnection!
```

### schema.graphql (1)

```graphql
  ping: String!
```

### tasksystem.graphql (15)

```graphql
  """
  Resolves the actual tasks belonging to a TaskList.
  - static  → TaskListItem rows in their hand-set order.
  - virtual → tasks matching the saved Filter (viewer-aware via @me / @today / etc).
  - hybrid  → virtual base + manual pins + excludes; manual ordering applied.
  viewerUserID resolves @me / @last_visit tokens.
  """
  resolveTaskList(
    listID: ID!
    viewerUserID: ID!
    limit: Int
    offset: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    tagsIn: [String!]
  ): [Task!]!
  """Total task count for a list. Honours the same search + filter args as
     resolveTaskList so the count matches the visible set."""
  resolveTaskListCount(
    listID: ID!
    viewerUserID: ID!
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    tagsIn: [String!]
  ): Int!
  """Batched resolution for the lists overview page — returns the project's
     visible lists together with their first `perListLimit` tasks plus
     totalCount per list, all in one round-trip. Replaces 1+2N round-trips
     (lists + per-list tasks/count) with a single query."""
  resolveProjectLists(
    projectID: ID!
    viewerUserID: ID!
    listLimit: Int
    perListLimit: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    """Tag names (case-insensitive) — task must carry EVERY listed tag to
       remain in the result (AND semantics, matches the picker UX)."""
    tagsIn: [String!]
  ): ProjectListsResolution!
  """Resolve a saved view (filter + manual includes − manual excludes) to its
     visible task set. Pagination + filters mirror resolveTaskList."""
  resolveListView(
    viewID: ID!
    viewerUserID: ID!
    limit: Int
    offset: Int
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    tagsIn: [String!]
  ): [Task!]!
  """Total visible task count for a view (same filter args as resolveListView)."""
  resolveListViewCount(
    viewID: ID!
    viewerUserID: ID!
    search: String
    statusIn: [String!]
    priorityIn: [String!]
    tagsIn: [String!]
  ): Int!
  """
  Inbox for the current viewer. v1 is single-channel (Web UI). userID is
  required until auth context is wired — accepts an explicit param to keep
  the surface usable for dev.
  """
  inbox(userID: ID!, filter: InboxFilter): [Notification!]!
  """
  Per-viewer unread badge counts.
  """
  inboxBadges(userID: ID!): InboxBadges!
  """
  Returns the typed link graph anchored at a task — outbound + inbound by
  kind.
  """
  linkedTasks(taskID: ID!): LinkedTasks!
  """Task counts per tag for one project, ordered by total desc then name.
     Tags with no attached tasks are omitted. Excludes archived tasks."""
  tagTaskCounts(projectID: ID!): [TagTaskCount!]!
```

### user_extended.graphql (4)

```graphql
  """
  Get a user by ID.
  """
  user(id: ID!): User
  """
  Get a user by email address.
  """
  userByEmail(email: String!): User @deprecated(reason: "Use users query with email filter instead")
  """
  Get user by ID - legacy endpoint.
  """
  getUser(id: ID!): User @deprecated(reason: "Use user(id) query instead. Will be removed in v2.0")
```

### workspace_layout.graphql (2)

```graphql
  """Fetch a specific layout by project+name. Null if none saved."""
  workspaceLayoutByName(projectId: ID!, name: String!): WorkspaceLayout
```

**Total queries: 61**

---

## Mutations (by SDL fragment)

### schema.graphql (1)

```graphql
  ping: String!
```

### scratchpad.graphql (6)

```graphql
  """Create a new scratch tab in a project."""
  createScratch(input: CreateScratchInput!): Scratch!
  """Update a scratch — used for debounced autosave (title/body/language),
     drag-reorder (position) and pin toggling (pinned)."""
  updateScratch(id: ID!, input: UpdateScratchInput!): Scratch!
  """Close a scratch tab — soft-archive into the trash drawer. The server
     stamps archivedAt so clients never pass timestamps."""
  archiveScratch(id: ID!): Scratch!
  """Reopen a scratch from the trash drawer (clears archivedAt)."""
  restoreScratch(id: ID!): Scratch!
  """Permanently delete a scratch. Irreversible — the UI only exposes this from
     the trash drawer, behind a confirmation. Returns true on success."""
  deleteScratch(id: ID!): Boolean!
```

### tasksystem.graphql (103)

```graphql
  voteIdea(id: ID!): Idea!
  promoteIdeaToTask(ideaID: ID!, ownerListID: ID, createdByUserID: ID): Idea!
  promoteIdeaToPlan(ideaID: ID!, specID: ID, createdByUserID: ID): Idea!
  rejectIdea(ideaID: ID!, reason: String): Idea!
  createArea(input: CreateAreaInput!): Area!
  updateArea(id: ID!, input: UpdateAreaInput!): Area!
  ensureAreaByName(projectID: ID!, name: String!): Area!
  createTask(input: CreateTaskInput!): Task!
  """Create many tasks in ONE transaction (all or none) and return them in
     input order — the "Paste tasks" dialog. Same invariants as createTask
     (subtasks never carry an owner list; a missing owner list defaults to the
     project Inbox). Positions are taken from each input as given. At most 500
     inputs per call."""
  createTasks(input: [CreateTaskInput!]!): [Task!]!
  updateTask(id: ID!, input: UpdateTaskInput!): Task!
  createBoard(input: CreateBoardInput!): Board!
  updateBoard(id: ID!, input: UpdateBoardInput!): Board!
  createLabel(input: CreateLabelInput!): Label!
  updateLabel(id: ID!, input: UpdateLabelInput!): Label!
  createTaskList(input: CreateTaskListInput!): TaskList!
  updateTaskList(id: ID!, input: UpdateTaskListInput!): TaskList!
  moveTask(taskID: ID!, status: String!, position: Float!): Task!
  moveTaskToList(taskID: ID!, ownerListID: ID!): Task!
  reorderTaskInList(taskID: ID!, ownerListID: ID!, beforeTaskID: ID): Task!
  assignTask(taskID: ID!, userID: ID, agentID: ID): Task!
  """Add a user to the task's collaborators (many-to-many junction). Idempotent —
     re-adding an active assignee returns the existing row."""
  addTaskAssignee(taskID: ID!, userID: ID!, assignedByUserID: ID): TaskAssignee!
  """Soft-delete an active assignment (sets unassigned_at). No-op if not active."""
  removeTaskAssignee(taskID: ID!, userID: ID!): Boolean!
  archiveTask(taskID: ID!): Task!
  restoreTask(taskID: ID!): Task!
  createComment(commentableType: CommentableType!, commentableID: ID!, body: String!, authorUserID: ID, authorAgentID: ID): Comment!
  updateComment(id: ID!, body: String!): Comment!
  deleteComment(id: ID!): Boolean!
  attachTag(taggableType: TaggableType!, taggableID: ID!, name: String!, createdByUserID: ID, createdByAgentID: ID): Taggable!
  detachTag(taggableType: TaggableType!, taggableID: ID!, name: String!): Boolean!
  """Create or return a workspace Tag library row. Lookup is case-insensitive
  on name within the workspace; `color` may be a hex string like #7c3aed
  or null to fall back to the deterministic hash palette."""
  ensureTag(workspaceID: ID!, name: String!, color: String, appliesTo: [String!]): Tag!
  """Rename / recolor / change applies-to filter. Rename is case-insensitive
  collision-detected — returns an error if another Tag in the workspace
  already owns the new name."""
  updateTag(id: ID!, name: String, color: String, appliesTo: [String!]): Tag!
  """Delete a Tag and every Taggables pointing at it (entcascade,
  transactional)."""
  deleteTag(id: ID!): Boolean!
  """Merge `fromID` into `intoID`: re-points every Taggables whose
  tag_id matches the source onto the destination, then deletes the source
  Tag. Both must be in the same workspace."""
  mergeTag(fromID: ID!, intoID: ID!): Tag!
  attachLabel(taskID: ID!, labelID: ID!): Task!
  detachLabel(taskID: ID!, labelID: ID!): Task!
  addTaskLink(taskID: ID!, targetTaskID: ID!, kind: TaskLinkKind!): TaskLink!
  removeTaskLink(taskID: ID!, targetTaskID: ID!, kind: TaskLinkKind!): Boolean!
  ensureDefaultBoard(projectID: ID!): Board!
  seedListsForProject(projectID: ID!, ownerUserID: ID!): [TaskList!]!
  """Hard-delete a TaskList together with its tasks, subtasks, items,
     excludes, orderings, and pins. Wrapped in a single transaction."""
  deleteTaskList(id: ID!): Boolean!
  """Hard-delete a Task and every nested subtask. Transactional."""
  deleteTask(id: ID!): Boolean!
  """Create a new saved view (filter + manual curation)."""
  createListView(input: CreateListViewInput!): ListView!
  """Update a saved view's name / filter / pin / position."""
  updateListView(id: ID!, input: UpdateListViewInput!): ListView!
  """Soft-delete a saved view (sets archived_at)."""
  archiveListView(id: ID!): ListView!
  """Pin a task to a view so it always appears, even if the filter doesn't match."""
  addTaskToListView(viewID: ID!, taskID: ID!, position: Float): ListViewInclude!
  """Remove a manual pin (does NOT affect filter-matched visibility)."""
  removeTaskFromListView(viewID: ID!, taskID: ID!): Boolean!
  """Hide a task from a view's filter results."""
  excludeTaskFromListView(viewID: ID!, taskID: ID!, reason: String): ListViewExclude!
  """Undo a previous excludeTaskFromListView call."""
  unexcludeTaskFromListView(viewID: ID!, taskID: ID!): Boolean!
  markNotificationRead(id: ID!): Notification!
  markAllNotificationsRead(userID: ID!): Int!
  archiveNotification(id: ID!): Notification!
  ensureAgent(userID: ID!, name: String!, kind: AgentKind, hostname: String, tty: String, cwd: String, gitBranch: String, sessionID: String): Agent!
  startRun(input: StartRunInput!): Run!
  finishRun(input: FinishRunInput!): Run!
  cancelRun(runID: ID!): Run!
  setRunPlan(runID: ID!, summary: String!, steps: [RunStepInput!]!): Run!
  requestPlanReview(runID: ID!): Run!
  startStep(stepID: ID!): RunStep!
  completeStep(stepID: ID!, notes: String, output: Map): RunStep!
  skipStep(stepID: ID!, reason: String!): RunStep!
  failStep(stepID: ID!, errorMessage: String!): RunStep!
  blockStep(stepID: ID!, reason: String!): RunStep!
  postReview(input: PostReviewInput!): Review!
  createIdea(input: CreateIdeaInput!): Idea!
  updateIdea(id: ID!, input: UpdateIdeaInput!): Idea!
  archiveIdea(id: ID!): Idea!
  unarchiveIdea(id: ID!): Idea!
  createSpec(input: CreateSpecInput!): Spec!
  updateSpec(id: ID!, input: UpdateSpecInput!): Spec!
  archiveSpec(id: ID!): Spec!
  unarchiveSpec(id: ID!): Spec!
  createPlan(input: CreatePlanInput!): Plan!
  updatePlan(id: ID!, input: UpdatePlanInput!): Plan!
  approvePlan(id: ID!, approvedByUserID: ID): Plan!
  activatePlan(id: ID!): Plan!
  archivePlan(id: ID!): Plan!
  unarchivePlan(id: ID!): Plan!
  addTaskToPlan(planID: ID!, taskID: ID!, position: Float): Boolean!
  removeTaskFromPlan(planID: ID!, taskID: ID!): Boolean!
  createDecision(input: CreateDecisionInput!): Decision!
  updateDecision(id: ID!, input: UpdateDecisionInput!): Decision!
  archiveDecision(id: ID!): Decision!
  unarchiveDecision(id: ID!): Decision!
  createMemory(input: CreateMemoryInput!): Memory!
  updateMemory(id: ID!, input: UpdateMemoryInput!): Memory!
  archiveMemory(id: ID!): Memory!
  unarchiveMemory(id: ID!): Memory!
  requestGate(input: RequestGateInput!): Gate!
  approveGate(id: ID!, decidedByUserID: ID): Gate!
  rejectGate(id: ID!, decidedByUserID: ID, reason: String): Gate!
  createTaskTemplate(input: CreateTaskTemplateInput!): TaskTemplate!
  updateTaskTemplate(id: ID!, input: UpdateTaskTemplateInput!): TaskTemplate!
  createSource(input: CreateSourceInput!): Source!
  updateSource(id: ID!, input: UpdateSourceInput!): Source!
  archiveSource(id: ID!): Source!
  unarchiveSource(id: ID!): Source!
  linkSource(sourceID: ID!, sourceableType: SourceableType!, sourceableID: ID!, position: Float): Boolean!
  unlinkSource(sourceID: ID!, sourceableType: SourceableType!, sourceableID: ID!): Boolean!
```

### workspace.graphql (13)

```graphql
  """Create a new project"""
  createProject(input: CreateProjectInput!): Project!
  """Update a project"""
  updateProject(id: ID!, input: UpdateProjectInput!): Project!
  """Delete a project"""
  deleteProject(id: ID!): Boolean!
  """Add a directory to a project"""
  createProjectDirectory(input: CreateProjectDirectoryInput!): ProjectDirectory!
  """Update a project directory"""
  updateProjectDirectory(id: ID!, input: UpdateProjectDirectoryInput!): ProjectDirectory!
  """Delete a project directory"""
  deleteProjectDirectory(id: ID!): Boolean!
  """Reorder project directories. Pass ordered list of directory IDs."""
  reorderProjectDirectories(projectId: ID!, directoryIds: [ID!]!): Boolean!
  """Reveal a path in the OS file manager (Finder/Explorer). Selects the file."""
  revealInFinder(path: String!): Boolean!
  """Create a designation"""
  createDesignation(input: CreateDesignationInput!): Designation!
  """Update a designation"""
  updateDesignation(id: ID!, input: UpdateDesignationInput!): Designation!
  """Add a member to a project"""
  createProjectMember(input: CreateProjectMemberInput!): ProjectMember!
  """Update a project member (e.g. set removed_at to soft-delete)"""
  updateProjectMember(id: ID!, input: UpdateProjectMemberInput!): ProjectMember!
```

### workspace_layout.graphql (2)

```graphql
  """Upsert a WorkspaceLayout for a project+name. Returns the saved row."""
  saveWorkspaceLayout(input: SaveWorkspaceLayoutInput!): WorkspaceLayout!
```

**Total mutations: 125**

---

## Object types (115)

### `Activity`  <sub>ent.graphql</sub>

```graphql
type Activity implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID
  specID: ID
  planID: ID
  decisionID: ID
  memoryID: ID
  entityKind: ActivityEntityKind!
  actorUserID: String
  actorAgentID: String
  kind: ActivityKind!
  before: Map
  after: Map
  task: Task
  spec: Spec
  plan: Plan
  decision: Decision
  memory: Memory
}
```

### `ActivityConnection`  <sub>ent.graphql</sub>

```graphql
type ActivityConnection {
  """
  A list of edges.
  """
  edges: [ActivityEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ActivityEdge`  <sub>ent.graphql</sub>

```graphql
type ActivityEdge {
  """
  The item at the end of the edge.
  """
  node: Activity
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Agent`  <sub>ent.graphql</sub>

```graphql
type Agent implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  userID: String!
  name: String!
  kind: AgentKind!
  sessionID: String
  hostname: String
  tty: String
  cwd: String
  gitBranch: String
  lastSeenAt: Time
}
```

### `AgentConnection`  <sub>ent.graphql</sub>

```graphql
type AgentConnection {
  """
  A list of edges.
  """
  edges: [AgentEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `AgentEdge`  <sub>ent.graphql</sub>

```graphql
type AgentEdge {
  """
  The item at the end of the edge.
  """
  node: Agent
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Area`  <sub>ent.graphql</sub>

```graphql
type Area implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  name: String!
  slug: String!
  description: String
  status: AreaStatus!
  leadUserID: String
  position: Float!
  archivedAt: Time
  project: Project!
  ideas: [Idea!]
  tasks: [Task!]
  taskLists: [TaskList!]
  sources: [Source!]
}
```

### `AreaConnection`  <sub>ent.graphql</sub>

```graphql
type AreaConnection {
  """
  A list of edges.
  """
  edges: [AreaEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `AreaEdge`  <sub>ent.graphql</sub>

```graphql
type AreaEdge {
  """
  The item at the end of the edge.
  """
  node: Area
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Attachment`  <sub>ent.graphql</sub>

```graphql
type Attachment implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  runID: String
  runStepID: String
  kind: AttachmentKind!
  s3Bucket: String
  s3Key: String
  contentType: String
  checksumSha256: String
  originalFilename: String
  gitSha: String
  gitPath: String
  url: String
  noteText: String
  sizeBytes: Int
  status: AttachmentStatus!
  uploadedByUserID: String
  uploadedByAgentID: String
  task: Task!
}
```

### `AttachmentConnection`  <sub>ent.graphql</sub>

```graphql
type AttachmentConnection {
  """
  A list of edges.
  """
  edges: [AttachmentEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `AttachmentEdge`  <sub>ent.graphql</sub>

```graphql
type AttachmentEdge {
  """
  The item at the end of the edge.
  """
  node: Attachment
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Board`  <sub>ent.graphql</sub>

```graphql
type Board implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  name: String!
  columns: [BoardColumn!]!
  isDefault: Boolean!
  position: Float!
  project: Project!
  tasks: [Task!]
}
```

### `BoardConnection`  <sub>ent.graphql</sub>

```graphql
type BoardConnection {
  """
  A list of edges.
  """
  edges: [BoardEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `BoardEdge`  <sub>ent.graphql</sub>

```graphql
type BoardEdge {
  """
  The item at the end of the edge.
  """
  node: Board
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Comment`  <sub>ent.graphql</sub>

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

### `CommentConnection`  <sub>ent.graphql</sub>

```graphql
type CommentConnection {
  """
  A list of edges.
  """
  edges: [CommentEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `CommentEdge`  <sub>ent.graphql</sub>

```graphql
type CommentEdge {
  """
  The item at the end of the edge.
  """
  node: Comment
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Decision`  <sub>ent.graphql</sub>

```graphql
type Decision implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String!
  taskID: String
  planID: String
  runID: String
  kind: DecisionKind!
  title: String!
  context: String
  decision: String
  alternatives: [String!]
  consequences: String
  status: DecisionStatus!
  attachmentID: String
  createdByUserID: String
  createdByAgentID: String
  archivedAt: Time
  activities: [Activity!]
}
```

### `DecisionConnection`  <sub>ent.graphql</sub>

```graphql
type DecisionConnection {
  """
  A list of edges.
  """
  edges: [DecisionEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `DecisionEdge`  <sub>ent.graphql</sub>

```graphql
type DecisionEdge {
  """
  The item at the end of the edge.
  """
  node: Decision
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Designation`  <sub>ent.graphql</sub>

```graphql
type Designation implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  name: String!
  description: String
  color: String
  sortOrder: Int!
  archivedAt: Time
  projectMembers: [ProjectMember!]
}
```

### `DesignationConnection`  <sub>ent.graphql</sub>

```graphql
type DesignationConnection {
  """
  A list of edges.
  """
  edges: [DesignationEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `DesignationEdge`  <sub>ent.graphql</sub>

```graphql
type DesignationEdge {
  """
  The item at the end of the edge.
  """
  node: Designation
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Gate`  <sub>ent.graphql</sub>

```graphql
type Gate implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: String!
  runID: String
  reason: String!
  status: GateStatus!
  requestedByAgentID: String
  approverUserID: String
  note: String
  requestedAt: Time
  decidedAt: Time
}
```

### `GateConnection`  <sub>ent.graphql</sub>

```graphql
type GateConnection {
  """
  A list of edges.
  """
  edges: [GateEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `GateEdge`  <sub>ent.graphql</sub>

```graphql
type GateEdge {
  """
  The item at the end of the edge.
  """
  node: Gate
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Idea`  <sub>ent.graphql</sub>

```graphql
type Idea implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  areaID: ID
  subject: String
  title: String!
  body: String
  status: IdeaStatus!
  votes: Int!
  sourceURL: String
  convertedTaskID: ID
  convertedPlanID: ID
  createdByUserID: String
  archivedAt: Time
  project: Project!
  area: Area
  convertedTask: Task
  convertedPlan: Plan
}
```

### `IdeaConnection`  <sub>ent.graphql</sub>

```graphql
type IdeaConnection {
  """
  A list of edges.
  """
  edges: [IdeaEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `IdeaEdge`  <sub>ent.graphql</sub>

```graphql
type IdeaEdge {
  """
  The item at the end of the edge.
  """
  node: Idea
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `InboxBadges`  <sub>tasksystem.graphql</sub>

```graphql
type InboxBadges {
  unreadTotal: Int!
  awaitingReview: Int!
  gates: Int!
  mentions: Int!
  failures: Int!
  assignments: Int!
}
```

### `Label`  <sub>ent.graphql</sub>

```graphql
type Label implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  name: String!
  color: String
  description: String
  project: Project!
  tasks: [Task!]
}
```

### `LabelConnection`  <sub>ent.graphql</sub>

```graphql
type LabelConnection {
  """
  A list of edges.
  """
  edges: [LabelEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `LabelEdge`  <sub>ent.graphql</sub>

```graphql
type LabelEdge {
  """
  The item at the end of the edge.
  """
  node: Label
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `LinkedTasks`  <sub>tasksystem.graphql</sub>

```graphql
type LinkedTasks {
  blocks: [Task!]!
  blockedBy: [Task!]!
  relatesTo: [Task!]!
  duplicates: [Task!]!
  duplicateOf: [Task!]!
  references: [Task!]!
  referencedBy: [Task!]!
}
```

### `ListView`  <sub>ent.graphql</sub>

```graphql
type ListView implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID
  ownerUserID: String!
  name: String!
  description: String
  filter: Map
  position: Float!
  pinned: Boolean!
  archivedAt: Time
  isSeeded: Boolean!
  project: Project
  includes: [ListViewInclude!]
  excludes: [ListViewExclude!]
}
```

### `ListViewConnection`  <sub>ent.graphql</sub>

```graphql
type ListViewConnection {
  """
  A list of edges.
  """
  edges: [ListViewEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ListViewEdge`  <sub>ent.graphql</sub>

```graphql
type ListViewEdge {
  """
  The item at the end of the edge.
  """
  node: ListView
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `ListViewExclude`  <sub>ent.graphql</sub>

```graphql
type ListViewExclude implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  viewID: ID!
  taskID: String!
  reason: String
  excludedByUserID: String
  view: ListView!
}
```

### `ListViewExcludeConnection`  <sub>ent.graphql</sub>

```graphql
type ListViewExcludeConnection {
  """
  A list of edges.
  """
  edges: [ListViewExcludeEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ListViewExcludeEdge`  <sub>ent.graphql</sub>

```graphql
type ListViewExcludeEdge {
  """
  The item at the end of the edge.
  """
  node: ListViewExclude
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `ListViewInclude`  <sub>ent.graphql</sub>

```graphql
type ListViewInclude implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  viewID: ID!
  taskID: String!
  position: Float!
  addedByUserID: String
  view: ListView!
}
```

### `ListViewIncludeConnection`  <sub>ent.graphql</sub>

```graphql
type ListViewIncludeConnection {
  """
  A list of edges.
  """
  edges: [ListViewIncludeEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ListViewIncludeEdge`  <sub>ent.graphql</sub>

```graphql
type ListViewIncludeEdge {
  """
  The item at the end of the edge.
  """
  node: ListViewInclude
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `MediaAttachment`  <sub>media_host.graphql</sub>

```graphql
extend type MediaAttachment {
  # Resolved host entity. Null when the host row has been deleted.
  host: AttachmentHost
}
```

### `Memory`  <sub>ent.graphql</sub>

```graphql
type Memory implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String!
  tag: MemoryTag!
  status: MemoryStatus!
  title: String!
  body: String!
  sourceTaskID: String
  sourceRunID: String
  createdByUserID: String
  createdByAgentID: String
  archivedAt: Time
  activities: [Activity!]
}
```

### `MemoryConnection`  <sub>ent.graphql</sub>

```graphql
type MemoryConnection {
  """
  A list of edges.
  """
  edges: [MemoryEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `MemoryEdge`  <sub>ent.graphql</sub>

```graphql
type MemoryEdge {
  """
  The item at the end of the edge.
  """
  node: Memory
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Notification`  <sub>ent.graphql</sub>

```graphql
type Notification implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  userID: String!
  eventKind: NotificationEventKind!
  projectID: String
  taskID: String
  runID: String
  gateID: String
  commentID: String
  actorUserID: String
  actorAgentID: String
  title: String!
  body: String
  link: String
  readAt: Time
  archivedAt: Time
}
```

### `NotificationConnection`  <sub>ent.graphql</sub>

```graphql
type NotificationConnection {
  """
  A list of edges.
  """
  edges: [NotificationEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `NotificationEdge`  <sub>ent.graphql</sub>

```graphql
type NotificationEdge {
  """
  The item at the end of the edge.
  """
  node: Notification
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `PageInfo`  <sub>ent.graphql</sub>

```graphql
type PageInfo {
  """
  When paginating forwards, are there more items?
  """
  hasNextPage: Boolean!
  """
  When paginating backwards, are there more items?
  """
  hasPreviousPage: Boolean!
  """
  When paginating backwards, the cursor to continue.
  """
  startCursor: Cursor
  """
  When paginating forwards, the cursor to continue.
  """
  endCursor: Cursor
}
```

### `Plan`  <sub>ent.graphql</sub>

```graphql
type Plan implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  specID: ID
  title: String!
  strategy: String
  status: PlanStatus!
  approvedByUserID: String
  approvedAt: Time
  createdByUserID: String
  archivedAt: Time
  project: Project!
  spec: Spec
  tasks: [Task!]
  activities: [Activity!]
  convertedFromIdeas: [Idea!]
}
```

### `PlanConnection`  <sub>ent.graphql</sub>

```graphql
type PlanConnection {
  """
  A list of edges.
  """
  edges: [PlanEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `PlanEdge`  <sub>ent.graphql</sub>

```graphql
type PlanEdge {
  """
  The item at the end of the edge.
  """
  node: Plan
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Project`  <sub>ent.graphql</sub>

```graphql
type Project implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  name: String!
  description: String
  status: String!
  directories: [ProjectDirectory!]
  workspaceLayouts: [WorkspaceLayout!]
  boards: [Board!]
  tasks: [Task!]
  labels: [Label!]
  taskLists: [TaskList!]
  specs: [Spec!]
  plans: [Plan!]
  ideas: [Idea!]
  areas: [Area!]
  sources: [Source!]
  scratches: [Scratch!]
  members: [ProjectMember!]
  listViews: [ListView!]
}
```

### `ProjectConnection`  <sub>ent.graphql</sub>

```graphql
type ProjectConnection {
  """
  A list of edges.
  """
  edges: [ProjectEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ProjectDirectory`  <sub>ent.graphql</sub>

```graphql
type ProjectDirectory implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  path: String!
  label: String
  isActive: Boolean!
  sortOrder: Int!
  project: Project!
}
```

### `ProjectDirectoryConnection`  <sub>ent.graphql</sub>

```graphql
type ProjectDirectoryConnection {
  """
  A list of edges.
  """
  edges: [ProjectDirectoryEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ProjectDirectoryEdge`  <sub>ent.graphql</sub>

```graphql
type ProjectDirectoryEdge {
  """
  The item at the end of the edge.
  """
  node: ProjectDirectory
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `ProjectEdge`  <sub>ent.graphql</sub>

```graphql
type ProjectEdge {
  """
  The item at the end of the edge.
  """
  node: Project
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `ProjectListsResolution`  <sub>tasksystem.graphql</sub>

```graphql
type ProjectListsResolution {
  """Visible lists capped to listLimit, each paired with their first
     `perListLimit` matching tasks + total matching count."""
  groups: [TaskListWithTasks!]!
  """Total non-archived list count for the project. Lets the caller render
     a 'View all N lists' link without a sidecar count query."""
  totalListCount: Int!
}
```

### `ProjectMember`  <sub>ent.graphql</sub>

```graphql
type ProjectMember implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  userID: ID!
  designationID: ID!
  joinedAt: Time!
  removedAt: Time
  note: String
  project: Project!
  user: User!
  designation: Designation!
}
```

### `ProjectMemberConnection`  <sub>ent.graphql</sub>

```graphql
type ProjectMemberConnection {
  """
  A list of edges.
  """
  edges: [ProjectMemberEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ProjectMemberEdge`  <sub>ent.graphql</sub>

```graphql
type ProjectMemberEdge {
  """
  The item at the end of the edge.
  """
  node: ProjectMember
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Review`  <sub>ent.graphql</sub>

```graphql
type Review implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  runID: ID!
  scope: ReviewScope!
  verdict: ReviewVerdict!
  reviewerUserID: String
  reviewerAgentID: String
  feedback: String
  feedbackStructured: Map
  task: Task!
  run: Run!
}
```

### `ReviewConnection`  <sub>ent.graphql</sub>

```graphql
type ReviewConnection {
  """
  A list of edges.
  """
  edges: [ReviewEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ReviewEdge`  <sub>ent.graphql</sub>

```graphql
type ReviewEdge {
  """
  The item at the end of the edge.
  """
  node: Review
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Run`  <sub>ent.graphql</sub>

```graphql
type Run implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  agentID: String
  attempt: Int!
  outcome: RunOutcome!
  errorKind: String
  errorMessage: String
  output: Map
  outputValid: Boolean
  summary: String
  approach: String
  reasoning: String
  reasoningAttachmentID: String
  toolsUsed: Map
  unresolved: Map
  confidence: RunConfidence
  model: String
  tokensIn: Int
  tokensOut: Int
  costUsd: Float
  durationMs: Int
  gitCommitSha: String
  gitFiles: [String!]
  planStatus: RunPlanStatus!
  planSummary: String
  planApprovedByUserID: String
  planApprovedAt: Time
  planRejectedAt: Time
  planFeedback: String
  startedAt: Time
  endedAt: Time
  task: Task!
  steps: [RunStep!]
  reviews: [Review!]
}
```

### `RunConnection`  <sub>ent.graphql</sub>

```graphql
type RunConnection {
  """
  A list of edges.
  """
  edges: [RunEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `RunEdge`  <sub>ent.graphql</sub>

```graphql
type RunEdge {
  """
  The item at the end of the edge.
  """
  node: Run
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `RunStep`  <sub>ent.graphql</sub>

```graphql
type RunStep implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  runID: ID!
  position: Float!
  title: String!
  rationale: String
  expectedOutput: Map
  status: RunStepStatus!
  blockedReason: String
  startedAt: Time
  finishedAt: Time
  notes: String
  output: Map
  errorMessage: String
  run: Run!
}
```

### `RunStepConnection`  <sub>ent.graphql</sub>

```graphql
type RunStepConnection {
  """
  A list of edges.
  """
  edges: [RunStepEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `RunStepEdge`  <sub>ent.graphql</sub>

```graphql
type RunStepEdge {
  """
  The item at the end of the edge.
  """
  node: RunStep
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Scratch`  <sub>ent.graphql</sub>

```graphql
type Scratch implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  title: String
  body: String
  language: String
  pinned: Boolean!
  position: Float!
  archivedAt: Time
  createdByUserID: String
  project: Project!
}
```

### `ScratchConnection`  <sub>ent.graphql</sub>

```graphql
type ScratchConnection {
  """
  A list of edges.
  """
  edges: [ScratchEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `ScratchEdge`  <sub>ent.graphql</sub>

```graphql
type ScratchEdge {
  """
  The item at the end of the edge.
  """
  node: Scratch
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Source`  <sub>ent.graphql</sub>

```graphql
type Source implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  areaID: ID
  kind: SourceKind!
  bodyFormat: SourceBodyFormat!
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  project: Project!
  area: Area
}
```

### `SourceConnection`  <sub>ent.graphql</sub>

```graphql
type SourceConnection {
  """
  A list of edges.
  """
  edges: [SourceEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `SourceEdge`  <sub>ent.graphql</sub>

```graphql
type SourceEdge {
  """
  The item at the end of the edge.
  """
  node: Source
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Spec`  <sub>ent.graphql</sub>

```graphql
type Spec implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  title: String!
  summary: String
  problem: String
  goals: [String!]
  constraints: [String!]
  successMetrics: [String!]
  status: SpecStatus!
  version: Int!
  createdByUserID: String
  archivedAt: Time
  project: Project!
  plans: [Plan!]
  activities: [Activity!]
}
```

### `SpecConnection`  <sub>ent.graphql</sub>

```graphql
type SpecConnection {
  """
  A list of edges.
  """
  edges: [SpecEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `SpecEdge`  <sub>ent.graphql</sub>

```graphql
type SpecEdge {
  """
  The item at the end of the edge.
  """
  node: Spec
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Tag`  <sub>ent.graphql</sub>

```graphql
type Tag implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String!
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String!
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  createdByUserID: String
  taggables: [Taggable!]
}
```

### `TagConnection`  <sub>ent.graphql</sub>

```graphql
type TagConnection {
  """
  A list of edges.
  """
  edges: [TagEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TagEdge`  <sub>ent.graphql</sub>

```graphql
type TagEdge {
  """
  The item at the end of the edge.
  """
  node: Tag
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `TagTaskCount`  <sub>tasksystem.graphql</sub>

```graphql
type TagTaskCount {
  tagID: ID!
  name: String!
  """Hex colour override from the tag library; empty when unset."""
  color: String!
  total: Int!
  """Tasks not finished — anything but done/cancelled."""
  open: Int!
  """Finished work: done OR cancelled."""
  done: Int!
}
```

### `Taggable`  <sub>ent.graphql</sub>

```graphql
type Taggable implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taggableID: String
  taggableType: String
  """
  FK to tags.id — the canonical Tag library row
  """
  tagID: ID!
  createdByUserID: String
  createdByAgentID: String
  tag: Tag!
}
```

### `TaggableConnection`  <sub>ent.graphql</sub>

```graphql
type TaggableConnection {
  """
  A list of edges.
  """
  edges: [TaggableEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaggableEdge`  <sub>ent.graphql</sub>

```graphql
type TaggableEdge {
  """
  The item at the end of the edge.
  """
  node: Taggable
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `Task`  <sub>ent.graphql</sub>

```graphql
type Task implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  boardID: ID!
  ownerListID: ID
  areaID: ID
  parentTaskID: ID
  title: String!
  description: String
  kind: TaskKind!
  status: String!
  priority: TaskPriority!
  effort: TaskEffort!
  estimateHours: Float
  position: Float!
  dueDate: Time
  assigneeUserID: String
  assigneeAgentID: String
  createdByUserID: String
  blockedReason: String
  startedAt: Time
  finishedAt: Time
  archivedAt: Time
  lastActivityAt: Time!
  requiresReview: Boolean!
  planReviewRequired: Boolean!
  project: Project!
  board: Board!
  ownerList: TaskList
  area: Area
  subtasks: [Task!]
  parent: Task
  activities: [Activity!]
  attachments: [Attachment!]
  labels: [Label!]
  links: [TaskLink!]
  runs: [Run!]
  reviews: [Review!]
  plans: [Plan!]
  convertedFromIdeas: [Idea!]
  assignees: [TaskAssignee!]
}
```

### `TaskAssignee`  <sub>ent.graphql</sub>

```graphql
type TaskAssignee implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  userID: ID!
  assignedAt: Time!
  assignedByUserID: String
  unassignedAt: Time
  note: String
  task: Task!
  user: User!
}
```

### `TaskAssigneeConnection`  <sub>ent.graphql</sub>

```graphql
type TaskAssigneeConnection {
  """
  A list of edges.
  """
  edges: [TaskAssigneeEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaskAssigneeEdge`  <sub>ent.graphql</sub>

```graphql
type TaskAssigneeEdge {
  """
  The item at the end of the edge.
  """
  node: TaskAssignee
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `TaskConnection`  <sub>ent.graphql</sub>

```graphql
type TaskConnection {
  """
  A list of edges.
  """
  edges: [TaskEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaskEdge`  <sub>ent.graphql</sub>

```graphql
type TaskEdge {
  """
  The item at the end of the edge.
  """
  node: Task
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `TaskLink`  <sub>ent.graphql</sub>

```graphql
type TaskLink implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  taskID: ID!
  targetTaskID: String!
  kind: TaskLinkKind!
  createdByUserID: String
  createdByAgentID: String
  task: Task!
}
```

### `TaskLinkConnection`  <sub>ent.graphql</sub>

```graphql
type TaskLinkConnection {
  """
  A list of edges.
  """
  edges: [TaskLinkEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaskLinkEdge`  <sub>ent.graphql</sub>

```graphql
type TaskLinkEdge {
  """
  The item at the end of the edge.
  """
  node: TaskLink
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `TaskList`  <sub>ent.graphql</sub>

```graphql
type TaskList implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: ID
  ownerUserID: String!
  name: String!
  description: String
  visibility: TaskListVisibility!
  isSeeded: Boolean!
  position: Float!
  pinned: Boolean!
  archivedAt: Time
  areaID: ID
  project: Project
  ownedTasks: [Task!]
  area: Area
}
```

### `TaskListConnection`  <sub>ent.graphql</sub>

```graphql
type TaskListConnection {
  """
  A list of edges.
  """
  edges: [TaskListEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaskListEdge`  <sub>ent.graphql</sub>

```graphql
type TaskListEdge {
  """
  The item at the end of the edge.
  """
  node: TaskList
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `TaskListWithTasks`  <sub>tasksystem.graphql</sub>

```graphql
type TaskListWithTasks {
  list: TaskList!
  tasks: [Task!]!
  totalCount: Int!
}
```

### `TaskTemplate`  <sub>ent.graphql</sub>

```graphql
type TaskTemplate implements Node {
  id: ID!
  workspaceID: String
  createdAt: Time
  updatedAt: Time
  projectID: String
  ownerUserID: String
  name: String!
  description: String
  defaultKind: String
  defaultPriority: String
  defaultEffort: String
  defaultAgentKind: String
  defaultAgentID: String
  defaultRetryPolicy: Map
  defaultTimeoutSeconds: Int
  defaultMaxCostUsd: Float
  defaultRequiresReview: Boolean!
  defaultAcceptanceCriteria: [String!]
  inputSchema: Map
  outputSchema: Map
  descriptionTemplate: String
  archivedAt: Time
}
```

### `TaskTemplateConnection`  <sub>ent.graphql</sub>

```graphql
type TaskTemplateConnection {
  """
  A list of edges.
  """
  edges: [TaskTemplateEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `TaskTemplateEdge`  <sub>ent.graphql</sub>

```graphql
type TaskTemplateEdge {
  """
  The item at the end of the edge.
  """
  node: TaskTemplate
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `User`  <sub>ent.graphql</sub>

```graphql
type User implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  firstName: String
  lastName: String
  email: String
  isActive: Boolean!
  status: String!
  sshKeys: [UserSshKey!]
  workspaceLayouts: [WorkspaceLayout!]
  projectMembers: [ProjectMember!]
  taskAssignments: [TaskAssignee!]
}
```

### `UserConnection`  <sub>ent.graphql</sub>

```graphql
type UserConnection {
  """
  A list of edges.
  """
  edges: [UserEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `UserEdge`  <sub>ent.graphql</sub>

```graphql
type UserEdge {
  """
  The item at the end of the edge.
  """
  node: User
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `UserSshKey`  <sub>ent.graphql</sub>

```graphql
type UserSshKey implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  userID: ID!
  fingerprint: String!
  publicKey: String!
  label: String
  lastUsedAt: Time
  user: User!
}
```

### `UserSshKeyConnection`  <sub>ent.graphql</sub>

```graphql
type UserSshKeyConnection {
  """
  A list of edges.
  """
  edges: [UserSshKeyEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `UserSshKeyEdge`  <sub>ent.graphql</sub>

```graphql
type UserSshKeyEdge {
  """
  The item at the end of the edge.
  """
  node: UserSshKey
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

### `WorkspaceLayout`  <sub>ent.graphql</sub>

```graphql
type WorkspaceLayout implements Node {
  id: ID!
  createdAt: Time
  updatedAt: Time
  projectID: ID!
  userID: ID
  name: String!
  isDefault: Boolean!
  spec: Map
  project: Project!
  user: User
}
```

### `WorkspaceLayoutConnection`  <sub>ent.graphql</sub>

```graphql
type WorkspaceLayoutConnection {
  """
  A list of edges.
  """
  edges: [WorkspaceLayoutEdge]
  """
  Information to aid in pagination.
  """
  pageInfo: PageInfo!
  """
  Identifies the total count of items in the connection.
  """
  totalCount: Int!
}
```

### `WorkspaceLayoutEdge`  <sub>ent.graphql</sub>

```graphql
type WorkspaceLayoutEdge {
  """
  The item at the end of the edge.
  """
  node: WorkspaceLayout
  """
  A cursor for use in pagination.
  """
  cursor: Cursor!
}
```

---

## Input types (121)

### `ActivityOrder`  <sub>ent.graphql</sub>

```graphql
input ActivityOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Activities.
  """
  field: ActivityOrderField!
}
```

### `ActivityWhereInput`  <sub>ent.graphql</sub>

```graphql
input ActivityWhereInput {
  not: ActivityWhereInput
  and: [ActivityWhereInput!]
  or: [ActivityWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDIsNil: Boolean
  taskIDNotNil: Boolean
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  spec_id field predicates
  """
  specID: ID
  specIDNEQ: ID
  specIDIn: [ID!]
  specIDNotIn: [ID!]
  specIDGT: ID
  specIDGTE: ID
  specIDLT: ID
  specIDLTE: ID
  specIDContains: ID
  specIDHasPrefix: ID
  specIDHasSuffix: ID
  specIDIsNil: Boolean
  specIDNotNil: Boolean
  specIDEqualFold: ID
  specIDContainsFold: ID
  """
  plan_id field predicates
  """
  planID: ID
  planIDNEQ: ID
  planIDIn: [ID!]
  planIDNotIn: [ID!]
  planIDGT: ID
  planIDGTE: ID
  planIDLT: ID
  planIDLTE: ID
  planIDContains: ID
  planIDHasPrefix: ID
  planIDHasSuffix: ID
  planIDIsNil: Boolean
  planIDNotNil: Boolean
  planIDEqualFold: ID
  planIDContainsFold: ID
  """
  decision_id field predicates
  """
  decisionID: ID
  decisionIDNEQ: ID
  decisionIDIn: [ID!]
  decisionIDNotIn: [ID!]
  decisionIDGT: ID
  decisionIDGTE: ID
  decisionIDLT: ID
  decisionIDLTE: ID
  decisionIDContains: ID
  decisionIDHasPrefix: ID
  decisionIDHasSuffix: ID
  decisionIDIsNil: Boolean
  decisionIDNotNil: Boolean
  decisionIDEqualFold: ID
  decisionIDContainsFold: ID
  """
  memory_id field predicates
  """
  memoryID: ID
  memoryIDNEQ: ID
  memoryIDIn: [ID!]
  memoryIDNotIn: [ID!]
  memoryIDGT: ID
  memoryIDGTE: ID
  memoryIDLT: ID
  memoryIDLTE: ID
  memoryIDContains: ID
  memoryIDHasPrefix: ID
  memoryIDHasSuffix: ID
  memoryIDIsNil: Boolean
  memoryIDNotNil: Boolean
  memoryIDEqualFold: ID
  memoryIDContainsFold: ID
  """
  entity_kind field predicates
  """
  entityKind: ActivityEntityKind
  entityKindNEQ: ActivityEntityKind
  entityKindIn: [ActivityEntityKind!]
  entityKindNotIn: [ActivityEntityKind!]
  """
  actor_user_id field predicates
  """
  actorUserID: String
  actorUserIDNEQ: String
  actorUserIDIn: [String!]
  actorUserIDNotIn: [String!]
  actorUserIDGT: String
  actorUserIDGTE: String
  actorUserIDLT: String
  actorUserIDLTE: String
  actorUserIDContains: String
  actorUserIDHasPrefix: String
  actorUserIDHasSuffix: String
  actorUserIDIsNil: Boolean
  actorUserIDNotNil: Boolean
  actorUserIDEqualFold: String
  actorUserIDContainsFold: String
  """
  actor_agent_id field predicates
  """
  actorAgentID: String
  actorAgentIDNEQ: String
  actorAgentIDIn: [String!]
  actorAgentIDNotIn: [String!]
  actorAgentIDGT: String
  actorAgentIDGTE: String
  actorAgentIDLT: String
  actorAgentIDLTE: String
  actorAgentIDContains: String
  actorAgentIDHasPrefix: String
  actorAgentIDHasSuffix: String
  actorAgentIDIsNil: Boolean
  actorAgentIDNotNil: Boolean
  actorAgentIDEqualFold: String
  actorAgentIDContainsFold: String
  """
  kind field predicates
  """
  kind: ActivityKind
  kindNEQ: ActivityKind
  kindIn: [ActivityKind!]
  kindNotIn: [ActivityKind!]
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
  """
  spec edge predicates
  """
  hasSpec: Boolean
  hasSpecWith: [SpecWhereInput!]
  """
  plan edge predicates
  """
  hasPlan: Boolean
  hasPlanWith: [PlanWhereInput!]
  """
  decision edge predicates
  """
  hasDecision: Boolean
  hasDecisionWith: [DecisionWhereInput!]
  """
  memory edge predicates
  """
  hasMemory: Boolean
  hasMemoryWith: [MemoryWhereInput!]
}
```

### `AgentOrder`  <sub>ent.graphql</sub>

```graphql
input AgentOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Agents.
  """
  field: AgentOrderField!
}
```

### `AgentWhereInput`  <sub>ent.graphql</sub>

```graphql
input AgentWhereInput {
  not: AgentWhereInput
  and: [AgentWhereInput!]
  or: [AgentWhereInput!]
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
  user_id field predicates
  """
  userID: String
  userIDNEQ: String
  userIDIn: [String!]
  userIDNotIn: [String!]
  userIDGT: String
  userIDGTE: String
  userIDLT: String
  userIDLTE: String
  userIDContains: String
  userIDHasPrefix: String
  userIDHasSuffix: String
  userIDEqualFold: String
  userIDContainsFold: String
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  kind field predicates
  """
  kind: AgentKind
  kindNEQ: AgentKind
  kindIn: [AgentKind!]
  kindNotIn: [AgentKind!]
  """
  session_id field predicates
  """
  sessionID: String
  sessionIDNEQ: String
  sessionIDIn: [String!]
  sessionIDNotIn: [String!]
  sessionIDGT: String
  sessionIDGTE: String
  sessionIDLT: String
  sessionIDLTE: String
  sessionIDContains: String
  sessionIDHasPrefix: String
  sessionIDHasSuffix: String
  sessionIDIsNil: Boolean
  sessionIDNotNil: Boolean
  sessionIDEqualFold: String
  sessionIDContainsFold: String
  """
  hostname field predicates
  """
  hostname: String
  hostnameNEQ: String
  hostnameIn: [String!]
  hostnameNotIn: [String!]
  hostnameGT: String
  hostnameGTE: String
  hostnameLT: String
  hostnameLTE: String
  hostnameContains: String
  hostnameHasPrefix: String
  hostnameHasSuffix: String
  hostnameIsNil: Boolean
  hostnameNotNil: Boolean
  hostnameEqualFold: String
  hostnameContainsFold: String
  """
  tty field predicates
  """
  tty: String
  ttyNEQ: String
  ttyIn: [String!]
  ttyNotIn: [String!]
  ttyGT: String
  ttyGTE: String
  ttyLT: String
  ttyLTE: String
  ttyContains: String
  ttyHasPrefix: String
  ttyHasSuffix: String
  ttyIsNil: Boolean
  ttyNotNil: Boolean
  ttyEqualFold: String
  ttyContainsFold: String
  """
  cwd field predicates
  """
  cwd: String
  cwdNEQ: String
  cwdIn: [String!]
  cwdNotIn: [String!]
  cwdGT: String
  cwdGTE: String
  cwdLT: String
  cwdLTE: String
  cwdContains: String
  cwdHasPrefix: String
  cwdHasSuffix: String
  cwdIsNil: Boolean
  cwdNotNil: Boolean
  cwdEqualFold: String
  cwdContainsFold: String
  """
  git_branch field predicates
  """
  gitBranch: String
  gitBranchNEQ: String
  gitBranchIn: [String!]
  gitBranchNotIn: [String!]
  gitBranchGT: String
  gitBranchGTE: String
  gitBranchLT: String
  gitBranchLTE: String
  gitBranchContains: String
  gitBranchHasPrefix: String
  gitBranchHasSuffix: String
  gitBranchIsNil: Boolean
  gitBranchNotNil: Boolean
  gitBranchEqualFold: String
  gitBranchContainsFold: String
  """
  last_seen_at field predicates
  """
  lastSeenAt: Time
  lastSeenAtNEQ: Time
  lastSeenAtIn: [Time!]
  lastSeenAtNotIn: [Time!]
  lastSeenAtGT: Time
  lastSeenAtGTE: Time
  lastSeenAtLT: Time
  lastSeenAtLTE: Time
  lastSeenAtIsNil: Boolean
  lastSeenAtNotNil: Boolean
}
```

### `AreaOrder`  <sub>ent.graphql</sub>

```graphql
input AreaOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Areas.
  """
  field: AreaOrderField!
}
```

### `AreaWhereInput`  <sub>ent.graphql</sub>

```graphql
input AreaWhereInput {
  not: AreaWhereInput
  and: [AreaWhereInput!]
  or: [AreaWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  slug field predicates
  """
  slug: String
  slugNEQ: String
  slugIn: [String!]
  slugNotIn: [String!]
  slugGT: String
  slugGTE: String
  slugLT: String
  slugLTE: String
  slugContains: String
  slugHasPrefix: String
  slugHasSuffix: String
  slugEqualFold: String
  slugContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  status field predicates
  """
  status: AreaStatus
  statusNEQ: AreaStatus
  statusIn: [AreaStatus!]
  statusNotIn: [AreaStatus!]
  """
  lead_user_id field predicates
  """
  leadUserID: String
  leadUserIDNEQ: String
  leadUserIDIn: [String!]
  leadUserIDNotIn: [String!]
  leadUserIDGT: String
  leadUserIDGTE: String
  leadUserIDLT: String
  leadUserIDLTE: String
  leadUserIDContains: String
  leadUserIDHasPrefix: String
  leadUserIDHasSuffix: String
  leadUserIDIsNil: Boolean
  leadUserIDNotNil: Boolean
  leadUserIDEqualFold: String
  leadUserIDContainsFold: String
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  ideas edge predicates
  """
  hasIdeas: Boolean
  hasIdeasWith: [IdeaWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  task_lists edge predicates
  """
  hasTaskLists: Boolean
  hasTaskListsWith: [TaskListWhereInput!]
  """
  sources edge predicates
  """
  hasSources: Boolean
  hasSourcesWith: [SourceWhereInput!]
}
```

### `AttachmentOrder`  <sub>ent.graphql</sub>

```graphql
input AttachmentOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Attachments.
  """
  field: AttachmentOrderField!
}
```

### `AttachmentWhereInput`  <sub>ent.graphql</sub>

```graphql
input AttachmentWhereInput {
  not: AttachmentWhereInput
  and: [AttachmentWhereInput!]
  or: [AttachmentWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  run_id field predicates
  """
  runID: String
  runIDNEQ: String
  runIDIn: [String!]
  runIDNotIn: [String!]
  runIDGT: String
  runIDGTE: String
  runIDLT: String
  runIDLTE: String
  runIDContains: String
  runIDHasPrefix: String
  runIDHasSuffix: String
  runIDIsNil: Boolean
  runIDNotNil: Boolean
  runIDEqualFold: String
  runIDContainsFold: String
  """
  run_step_id field predicates
  """
  runStepID: String
  runStepIDNEQ: String
  runStepIDIn: [String!]
  runStepIDNotIn: [String!]
  runStepIDGT: String
  runStepIDGTE: String
  runStepIDLT: String
  runStepIDLTE: String
  runStepIDContains: String
  runStepIDHasPrefix: String
  runStepIDHasSuffix: String
  runStepIDIsNil: Boolean
  runStepIDNotNil: Boolean
  runStepIDEqualFold: String
  runStepIDContainsFold: String
  """
  kind field predicates
  """
  kind: AttachmentKind
  kindNEQ: AttachmentKind
  kindIn: [AttachmentKind!]
  kindNotIn: [AttachmentKind!]
  """
  s3_bucket field predicates
  """
  s3Bucket: String
  s3BucketNEQ: String
  s3BucketIn: [String!]
  s3BucketNotIn: [String!]
  s3BucketGT: String
  s3BucketGTE: String
  s3BucketLT: String
  s3BucketLTE: String
  s3BucketContains: String
  s3BucketHasPrefix: String
  s3BucketHasSuffix: String
  s3BucketIsNil: Boolean
  s3BucketNotNil: Boolean
  s3BucketEqualFold: String
  s3BucketContainsFold: String
  """
  s3_key field predicates
  """
  s3Key: String
  s3KeyNEQ: String
  s3KeyIn: [String!]
  s3KeyNotIn: [String!]
  s3KeyGT: String
  s3KeyGTE: String
  s3KeyLT: String
  s3KeyLTE: String
  s3KeyContains: String
  s3KeyHasPrefix: String
  s3KeyHasSuffix: String
  s3KeyIsNil: Boolean
  s3KeyNotNil: Boolean
  s3KeyEqualFold: String
  s3KeyContainsFold: String
  """
  content_type field predicates
  """
  contentType: String
  contentTypeNEQ: String
  contentTypeIn: [String!]
  contentTypeNotIn: [String!]
  contentTypeGT: String
  contentTypeGTE: String
  contentTypeLT: String
  contentTypeLTE: String
  contentTypeContains: String
  contentTypeHasPrefix: String
  contentTypeHasSuffix: String
  contentTypeIsNil: Boolean
  contentTypeNotNil: Boolean
  contentTypeEqualFold: String
  contentTypeContainsFold: String
  """
  checksum_sha256 field predicates
  """
  checksumSha256: String
  checksumSha256NEQ: String
  checksumSha256In: [String!]
  checksumSha256NotIn: [String!]
  checksumSha256GT: String
  checksumSha256GTE: String
  checksumSha256LT: String
  checksumSha256LTE: String
  checksumSha256Contains: String
  checksumSha256HasPrefix: String
  checksumSha256HasSuffix: String
  checksumSha256IsNil: Boolean
  checksumSha256NotNil: Boolean
  checksumSha256EqualFold: String
  checksumSha256ContainsFold: String
  """
  original_filename field predicates
  """
  originalFilename: String
  originalFilenameNEQ: String
  originalFilenameIn: [String!]
  originalFilenameNotIn: [String!]
  originalFilenameGT: String
  originalFilenameGTE: String
  originalFilenameLT: String
  originalFilenameLTE: String
  originalFilenameContains: String
  originalFilenameHasPrefix: String
  originalFilenameHasSuffix: String
  originalFilenameIsNil: Boolean
  originalFilenameNotNil: Boolean
  originalFilenameEqualFold: String
  originalFilenameContainsFold: String
  """
  git_sha field predicates
  """
  gitSha: String
  gitShaNEQ: String
  gitShaIn: [String!]
  gitShaNotIn: [String!]
  gitShaGT: String
  gitShaGTE: String
  gitShaLT: String
  gitShaLTE: String
  gitShaContains: String
  gitShaHasPrefix: String
  gitShaHasSuffix: String
  gitShaIsNil: Boolean
  gitShaNotNil: Boolean
  gitShaEqualFold: String
  gitShaContainsFold: String
  """
  git_path field predicates
  """
  gitPath: String
  gitPathNEQ: String
  gitPathIn: [String!]
  gitPathNotIn: [String!]
  gitPathGT: String
  gitPathGTE: String
  gitPathLT: String
  gitPathLTE: String
  gitPathContains: String
  gitPathHasPrefix: String
  gitPathHasSuffix: String
  gitPathIsNil: Boolean
  gitPathNotNil: Boolean
  gitPathEqualFold: String
  gitPathContainsFold: String
  """
  url field predicates
  """
  url: String
  urlNEQ: String
  urlIn: [String!]
  urlNotIn: [String!]
  urlGT: String
  urlGTE: String
  urlLT: String
  urlLTE: String
  urlContains: String
  urlHasPrefix: String
  urlHasSuffix: String
  urlIsNil: Boolean
  urlNotNil: Boolean
  urlEqualFold: String
  urlContainsFold: String
  """
  note_text field predicates
  """
  noteText: String
  noteTextNEQ: String
  noteTextIn: [String!]
  noteTextNotIn: [String!]
  noteTextGT: String
  noteTextGTE: String
  noteTextLT: String
  noteTextLTE: String
  noteTextContains: String
  noteTextHasPrefix: String
  noteTextHasSuffix: String
  noteTextIsNil: Boolean
  noteTextNotNil: Boolean
  noteTextEqualFold: String
  noteTextContainsFold: String
  """
  size_bytes field predicates
  """
  sizeBytes: Int
  sizeBytesNEQ: Int
  sizeBytesIn: [Int!]
  sizeBytesNotIn: [Int!]
  sizeBytesGT: Int
  sizeBytesGTE: Int
  sizeBytesLT: Int
  sizeBytesLTE: Int
  sizeBytesIsNil: Boolean
  sizeBytesNotNil: Boolean
  """
  status field predicates
  """
  status: AttachmentStatus
  statusNEQ: AttachmentStatus
  statusIn: [AttachmentStatus!]
  statusNotIn: [AttachmentStatus!]
  """
  uploaded_by_user_id field predicates
  """
  uploadedByUserID: String
  uploadedByUserIDNEQ: String
  uploadedByUserIDIn: [String!]
  uploadedByUserIDNotIn: [String!]
  uploadedByUserIDGT: String
  uploadedByUserIDGTE: String
  uploadedByUserIDLT: String
  uploadedByUserIDLTE: String
  uploadedByUserIDContains: String
  uploadedByUserIDHasPrefix: String
  uploadedByUserIDHasSuffix: String
  uploadedByUserIDIsNil: Boolean
  uploadedByUserIDNotNil: Boolean
  uploadedByUserIDEqualFold: String
  uploadedByUserIDContainsFold: String
  """
  uploaded_by_agent_id field predicates
  """
  uploadedByAgentID: String
  uploadedByAgentIDNEQ: String
  uploadedByAgentIDIn: [String!]
  uploadedByAgentIDNotIn: [String!]
  uploadedByAgentIDGT: String
  uploadedByAgentIDGTE: String
  uploadedByAgentIDLT: String
  uploadedByAgentIDLTE: String
  uploadedByAgentIDContains: String
  uploadedByAgentIDHasPrefix: String
  uploadedByAgentIDHasSuffix: String
  uploadedByAgentIDIsNil: Boolean
  uploadedByAgentIDNotNil: Boolean
  uploadedByAgentIDEqualFold: String
  uploadedByAgentIDContainsFold: String
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
}
```

### `BoardColumnInput`  <sub>tasksystem.graphql</sub>

```graphql
input BoardColumnInput {
  key: String!
  label: String!
  color: String
}
```

### `BoardOrder`  <sub>ent.graphql</sub>

```graphql
input BoardOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Boards.
  """
  field: BoardOrderField!
}
```

### `BoardWhereInput`  <sub>ent.graphql</sub>

```graphql
input BoardWhereInput {
  not: BoardWhereInput
  and: [BoardWhereInput!]
  or: [BoardWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  is_default field predicates
  """
  isDefault: Boolean
  isDefaultNEQ: Boolean
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
}
```

### `CommentOrder`  <sub>ent.graphql</sub>

```graphql
input CommentOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Comments.
  """
  field: CommentOrderField!
}
```

### `CommentWhereInput`  <sub>ent.graphql</sub>

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

### `CreateAreaInput`  <sub>ent.graphql</sub>

```graphql
input CreateAreaInput {
  workspaceID: String
  name: String!
  slug: String!
  description: String
  status: AreaStatus
  leadUserID: String
  position: Float
  archivedAt: Time
  projectID: ID!
  ideaIDs: [ID!]
  taskIDs: [ID!]
  taskListIDs: [ID!]
  sourceIDs: [ID!]
}
```

### `CreateBoardInput`  <sub>ent.graphql</sub>

```graphql
input CreateBoardInput {
  workspaceID: String
  name: String!
  isDefault: Boolean
  position: Float
  projectID: ID!
  taskIDs: [ID!]
}
```

### `CreateCommentInput`  <sub>ent.graphql</sub>

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

### `CreateDecisionInput`  <sub>ent.graphql</sub>

```graphql
input CreateDecisionInput {
  workspaceID: String
  projectID: String!
  taskID: String
  planID: String
  runID: String
  kind: DecisionKind
  title: String!
  context: String
  decision: String
  alternatives: [String!]
  consequences: String
  status: DecisionStatus
  attachmentID: String
  createdByUserID: String
  createdByAgentID: String
  archivedAt: Time
  activityIDs: [ID!]
}
```

### `CreateDesignationInput`  <sub>ent.graphql</sub>

```graphql
input CreateDesignationInput {
  workspaceID: String
  name: String!
  description: String
  color: String
  sortOrder: Int
  archivedAt: Time
  projectMemberIDs: [ID!]
}
```

### `CreateIdeaInput`  <sub>ent.graphql</sub>

```graphql
input CreateIdeaInput {
  workspaceID: String
  subject: String
  title: String!
  body: String
  status: IdeaStatus
  votes: Int
  sourceURL: String
  createdByUserID: String
  archivedAt: Time
  projectID: ID!
  areaID: ID
  convertedTaskID: ID
  convertedPlanID: ID
}
```

### `CreateLabelInput`  <sub>ent.graphql</sub>

```graphql
input CreateLabelInput {
  workspaceID: String
  name: String!
  color: String
  description: String
  projectID: ID!
  taskIDs: [ID!]
}
```

### `CreateListViewInput`  <sub>ent.graphql</sub>

```graphql
input CreateListViewInput {
  workspaceID: String
  ownerUserID: String!
  name: String!
  description: String
  position: Float
  pinned: Boolean
  archivedAt: Time
  isSeeded: Boolean
  projectID: ID
  includeIDs: [ID!]
  excludeIDs: [ID!]
}
```

### `CreateMemoryInput`  <sub>ent.graphql</sub>

```graphql
input CreateMemoryInput {
  workspaceID: String
  projectID: String!
  tag: MemoryTag
  status: MemoryStatus
  title: String!
  body: String!
  sourceTaskID: String
  sourceRunID: String
  createdByUserID: String
  createdByAgentID: String
  archivedAt: Time
  activityIDs: [ID!]
}
```

### `CreatePlanInput`  <sub>ent.graphql</sub>

```graphql
input CreatePlanInput {
  workspaceID: String
  title: String!
  strategy: String
  status: PlanStatus
  approvedByUserID: String
  approvedAt: Time
  createdByUserID: String
  archivedAt: Time
  projectID: ID!
  specID: ID
  taskIDs: [ID!]
  activityIDs: [ID!]
  convertedFromIdeaIDs: [ID!]
}
```

### `CreateProjectDirectoryInput`  <sub>ent.graphql</sub>

```graphql
input CreateProjectDirectoryInput {
  workspaceID: String
  path: String!
  label: String
  isActive: Boolean
  sortOrder: Int
  projectID: ID!
}
```

### `CreateProjectInput`  <sub>ent.graphql</sub>

```graphql
input CreateProjectInput {
  workspaceID: String
  name: String!
  description: String
  status: String
  directoryIDs: [ID!]
  workspaceLayoutIDs: [ID!]
  boardIDs: [ID!]
  taskIDs: [ID!]
  labelIDs: [ID!]
  taskListIDs: [ID!]
  specIDs: [ID!]
  planIDs: [ID!]
  ideaIDs: [ID!]
  areaIDs: [ID!]
  sourceIDs: [ID!]
  scratchIDs: [ID!]
  memberIDs: [ID!]
  listViewIDs: [ID!]
}
```

### `CreateProjectMemberInput`  <sub>ent.graphql</sub>

```graphql
input CreateProjectMemberInput {
  joinedAt: Time!
  removedAt: Time
  note: String
  projectID: ID!
  userID: ID!
  designationID: ID!
}
```

### `CreateScratchInput`  <sub>ent.graphql</sub>

```graphql
input CreateScratchInput {
  workspaceID: String
  title: String
  body: String
  language: String
  pinned: Boolean
  position: Float
  archivedAt: Time
  createdByUserID: String
  projectID: ID!
}
```

### `CreateSourceInput`  <sub>ent.graphql</sub>

```graphql
input CreateSourceInput {
  workspaceID: String
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String!
  summary: String
  body: String
  externalURL: String
  fileID: String
  mime: String
  tags: [String!]
  capturedByUserID: String
  capturedByAgentID: String
  archivedAt: Time
  projectID: ID!
  areaID: ID
}
```

### `CreateSpecInput`  <sub>ent.graphql</sub>

```graphql
input CreateSpecInput {
  workspaceID: String
  title: String!
  summary: String
  problem: String
  goals: [String!]
  constraints: [String!]
  successMetrics: [String!]
  status: SpecStatus
  version: Int
  createdByUserID: String
  archivedAt: Time
  projectID: ID!
  planIDs: [ID!]
  activityIDs: [ID!]
}
```

### `CreateTagInput`  <sub>ent.graphql</sub>

```graphql
input CreateTagInput {
  workspaceID: String
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String!
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String!
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  createdByUserID: String
  taggableIDs: [ID!]
}
```

### `CreateTaskInput`  <sub>ent.graphql</sub>

```graphql
input CreateTaskInput {
  workspaceID: String
  title: String!
  description: String
  kind: TaskKind
  status: String
  priority: TaskPriority
  effort: TaskEffort
  estimateHours: Float
  position: Float
  dueDate: Time
  assigneeUserID: String
  assigneeAgentID: String
  createdByUserID: String
  blockedReason: String
  startedAt: Time
  finishedAt: Time
  archivedAt: Time
  lastActivityAt: Time
  requiresReview: Boolean
  planReviewRequired: Boolean
  projectID: ID!
  boardID: ID!
  ownerListID: ID
  areaID: ID
  subtaskIDs: [ID!]
  parentID: ID
  activityIDs: [ID!]
  attachmentIDs: [ID!]
  labelIDs: [ID!]
  linkIDs: [ID!]
  runIDs: [ID!]
  reviewIDs: [ID!]
  planIDs: [ID!]
  convertedFromIdeaIDs: [ID!]
  assigneeIDs: [ID!]
}
```

### `CreateTaskLinkInput`  <sub>ent.graphql</sub>

```graphql
input CreateTaskLinkInput {
  workspaceID: String
  targetTaskID: String!
  kind: TaskLinkKind!
  createdByUserID: String
  createdByAgentID: String
  taskID: ID!
}
```

### `CreateTaskListInput`  <sub>ent.graphql</sub>

```graphql
input CreateTaskListInput {
  workspaceID: String
  ownerUserID: String!
  name: String!
  description: String
  visibility: TaskListVisibility
  isSeeded: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  projectID: ID
  ownedTaskIDs: [ID!]
  areaID: ID
}
```

### `CreateTaskTemplateInput`  <sub>ent.graphql</sub>

```graphql
input CreateTaskTemplateInput {
  workspaceID: String
  projectID: String
  ownerUserID: String
  name: String!
  description: String
  defaultKind: String
  defaultPriority: String
  defaultEffort: String
  defaultAgentKind: String
  defaultAgentID: String
  defaultTimeoutSeconds: Int
  defaultMaxCostUsd: Float
  defaultRequiresReview: Boolean
  descriptionTemplate: String
  archivedAt: Time
}
```

### `DecisionOrder`  <sub>ent.graphql</sub>

```graphql
input DecisionOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Decisions.
  """
  field: DecisionOrderField!
}
```

### `DecisionWhereInput`  <sub>ent.graphql</sub>

```graphql
input DecisionWhereInput {
  not: DecisionWhereInput
  and: [DecisionWhereInput!]
  or: [DecisionWhereInput!]
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
  project_id field predicates
  """
  projectID: String
  projectIDNEQ: String
  projectIDIn: [String!]
  projectIDNotIn: [String!]
  projectIDGT: String
  projectIDGTE: String
  projectIDLT: String
  projectIDLTE: String
  projectIDContains: String
  projectIDHasPrefix: String
  projectIDHasSuffix: String
  projectIDEqualFold: String
  projectIDContainsFold: String
  """
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDIsNil: Boolean
  taskIDNotNil: Boolean
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  plan_id field predicates
  """
  planID: String
  planIDNEQ: String
  planIDIn: [String!]
  planIDNotIn: [String!]
  planIDGT: String
  planIDGTE: String
  planIDLT: String
  planIDLTE: String
  planIDContains: String
  planIDHasPrefix: String
  planIDHasSuffix: String
  planIDIsNil: Boolean
  planIDNotNil: Boolean
  planIDEqualFold: String
  planIDContainsFold: String
  """
  run_id field predicates
  """
  runID: String
  runIDNEQ: String
  runIDIn: [String!]
  runIDNotIn: [String!]
  runIDGT: String
  runIDGTE: String
  runIDLT: String
  runIDLTE: String
  runIDContains: String
  runIDHasPrefix: String
  runIDHasSuffix: String
  runIDIsNil: Boolean
  runIDNotNil: Boolean
  runIDEqualFold: String
  runIDContainsFold: String
  """
  kind field predicates
  """
  kind: DecisionKind
  kindNEQ: DecisionKind
  kindIn: [DecisionKind!]
  kindNotIn: [DecisionKind!]
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  context field predicates
  """
  context: String
  contextNEQ: String
  contextIn: [String!]
  contextNotIn: [String!]
  contextGT: String
  contextGTE: String
  contextLT: String
  contextLTE: String
  contextContains: String
  contextHasPrefix: String
  contextHasSuffix: String
  contextIsNil: Boolean
  contextNotNil: Boolean
  contextEqualFold: String
  contextContainsFold: String
  """
  decision field predicates
  """
  decision: String
  decisionNEQ: String
  decisionIn: [String!]
  decisionNotIn: [String!]
  decisionGT: String
  decisionGTE: String
  decisionLT: String
  decisionLTE: String
  decisionContains: String
  decisionHasPrefix: String
  decisionHasSuffix: String
  decisionIsNil: Boolean
  decisionNotNil: Boolean
  decisionEqualFold: String
  decisionContainsFold: String
  """
  consequences field predicates
  """
  consequences: String
  consequencesNEQ: String
  consequencesIn: [String!]
  consequencesNotIn: [String!]
  consequencesGT: String
  consequencesGTE: String
  consequencesLT: String
  consequencesLTE: String
  consequencesContains: String
  consequencesHasPrefix: String
  consequencesHasSuffix: String
  consequencesIsNil: Boolean
  consequencesNotNil: Boolean
  consequencesEqualFold: String
  consequencesContainsFold: String
  """
  status field predicates
  """
  status: DecisionStatus
  statusNEQ: DecisionStatus
  statusIn: [DecisionStatus!]
  statusNotIn: [DecisionStatus!]
  """
  attachment_id field predicates
  """
  attachmentID: String
  attachmentIDNEQ: String
  attachmentIDIn: [String!]
  attachmentIDNotIn: [String!]
  attachmentIDGT: String
  attachmentIDGTE: String
  attachmentIDLT: String
  attachmentIDLTE: String
  attachmentIDContains: String
  attachmentIDHasPrefix: String
  attachmentIDHasSuffix: String
  attachmentIDIsNil: Boolean
  attachmentIDNotNil: Boolean
  attachmentIDEqualFold: String
  attachmentIDContainsFold: String
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  created_by_agent_id field predicates
  """
  createdByAgentID: String
  createdByAgentIDNEQ: String
  createdByAgentIDIn: [String!]
  createdByAgentIDNotIn: [String!]
  createdByAgentIDGT: String
  createdByAgentIDGTE: String
  createdByAgentIDLT: String
  createdByAgentIDLTE: String
  createdByAgentIDContains: String
  createdByAgentIDHasPrefix: String
  createdByAgentIDHasSuffix: String
  createdByAgentIDIsNil: Boolean
  createdByAgentIDNotNil: Boolean
  createdByAgentIDEqualFold: String
  createdByAgentIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
}
```

### `DesignationOrder`  <sub>ent.graphql</sub>

```graphql
input DesignationOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Designations.
  """
  field: DesignationOrderField!
}
```

### `DesignationWhereInput`  <sub>ent.graphql</sub>

```graphql
input DesignationWhereInput {
  not: DesignationWhereInput
  and: [DesignationWhereInput!]
  or: [DesignationWhereInput!]
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
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  color field predicates
  """
  color: String
  colorNEQ: String
  colorIn: [String!]
  colorNotIn: [String!]
  colorGT: String
  colorGTE: String
  colorLT: String
  colorLTE: String
  colorContains: String
  colorHasPrefix: String
  colorHasSuffix: String
  colorIsNil: Boolean
  colorNotNil: Boolean
  colorEqualFold: String
  colorContainsFold: String
  """
  sort_order field predicates
  """
  sortOrder: Int
  sortOrderNEQ: Int
  sortOrderIn: [Int!]
  sortOrderNotIn: [Int!]
  sortOrderGT: Int
  sortOrderGTE: Int
  sortOrderLT: Int
  sortOrderLTE: Int
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project_members edge predicates
  """
  hasProjectMembers: Boolean
  hasProjectMembersWith: [ProjectMemberWhereInput!]
}
```

### `FinishRunInput`  <sub>tasksystem.graphql</sub>

```graphql
input FinishRunInput {
  runID: ID!
  outcome: RunOutcome!
  errorKind: String
  errorMessage: String
  output: Map
  outputValid: Boolean
  summary: String
  approach: String
  reasoning: String
  toolsUsed: Map
  confidence: RunConfidence
  unresolved: Map
  model: String
  tokensIn: Int
  tokensOut: Int
  costUsd: Float
  durationMs: Int
  gitCommitSha: String
  gitFiles: [String!]
}
```

### `GateOrder`  <sub>ent.graphql</sub>

```graphql
input GateOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Gates.
  """
  field: GateOrderField!
}
```

### `GateWhereInput`  <sub>ent.graphql</sub>

```graphql
input GateWhereInput {
  not: GateWhereInput
  and: [GateWhereInput!]
  or: [GateWhereInput!]
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
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  run_id field predicates
  """
  runID: String
  runIDNEQ: String
  runIDIn: [String!]
  runIDNotIn: [String!]
  runIDGT: String
  runIDGTE: String
  runIDLT: String
  runIDLTE: String
  runIDContains: String
  runIDHasPrefix: String
  runIDHasSuffix: String
  runIDIsNil: Boolean
  runIDNotNil: Boolean
  runIDEqualFold: String
  runIDContainsFold: String
  """
  reason field predicates
  """
  reason: String
  reasonNEQ: String
  reasonIn: [String!]
  reasonNotIn: [String!]
  reasonGT: String
  reasonGTE: String
  reasonLT: String
  reasonLTE: String
  reasonContains: String
  reasonHasPrefix: String
  reasonHasSuffix: String
  reasonEqualFold: String
  reasonContainsFold: String
  """
  status field predicates
  """
  status: GateStatus
  statusNEQ: GateStatus
  statusIn: [GateStatus!]
  statusNotIn: [GateStatus!]
  """
  requested_by_agent_id field predicates
  """
  requestedByAgentID: String
  requestedByAgentIDNEQ: String
  requestedByAgentIDIn: [String!]
  requestedByAgentIDNotIn: [String!]
  requestedByAgentIDGT: String
  requestedByAgentIDGTE: String
  requestedByAgentIDLT: String
  requestedByAgentIDLTE: String
  requestedByAgentIDContains: String
  requestedByAgentIDHasPrefix: String
  requestedByAgentIDHasSuffix: String
  requestedByAgentIDIsNil: Boolean
  requestedByAgentIDNotNil: Boolean
  requestedByAgentIDEqualFold: String
  requestedByAgentIDContainsFold: String
  """
  approver_user_id field predicates
  """
  approverUserID: String
  approverUserIDNEQ: String
  approverUserIDIn: [String!]
  approverUserIDNotIn: [String!]
  approverUserIDGT: String
  approverUserIDGTE: String
  approverUserIDLT: String
  approverUserIDLTE: String
  approverUserIDContains: String
  approverUserIDHasPrefix: String
  approverUserIDHasSuffix: String
  approverUserIDIsNil: Boolean
  approverUserIDNotNil: Boolean
  approverUserIDEqualFold: String
  approverUserIDContainsFold: String
  """
  note field predicates
  """
  note: String
  noteNEQ: String
  noteIn: [String!]
  noteNotIn: [String!]
  noteGT: String
  noteGTE: String
  noteLT: String
  noteLTE: String
  noteContains: String
  noteHasPrefix: String
  noteHasSuffix: String
  noteIsNil: Boolean
  noteNotNil: Boolean
  noteEqualFold: String
  noteContainsFold: String
  """
  requested_at field predicates
  """
  requestedAt: Time
  requestedAtNEQ: Time
  requestedAtIn: [Time!]
  requestedAtNotIn: [Time!]
  requestedAtGT: Time
  requestedAtGTE: Time
  requestedAtLT: Time
  requestedAtLTE: Time
  requestedAtIsNil: Boolean
  requestedAtNotNil: Boolean
  """
  decided_at field predicates
  """
  decidedAt: Time
  decidedAtNEQ: Time
  decidedAtIn: [Time!]
  decidedAtNotIn: [Time!]
  decidedAtGT: Time
  decidedAtGTE: Time
  decidedAtLT: Time
  decidedAtLTE: Time
  decidedAtIsNil: Boolean
  decidedAtNotNil: Boolean
}
```

### `IdeaOrder`  <sub>ent.graphql</sub>

```graphql
input IdeaOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Ideas.
  """
  field: IdeaOrderField!
}
```

### `IdeaWhereInput`  <sub>ent.graphql</sub>

```graphql
input IdeaWhereInput {
  not: IdeaWhereInput
  and: [IdeaWhereInput!]
  or: [IdeaWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  subject field predicates
  """
  subject: String
  subjectNEQ: String
  subjectIn: [String!]
  subjectNotIn: [String!]
  subjectGT: String
  subjectGTE: String
  subjectLT: String
  subjectLTE: String
  subjectContains: String
  subjectHasPrefix: String
  subjectHasSuffix: String
  subjectIsNil: Boolean
  subjectNotNil: Boolean
  subjectEqualFold: String
  subjectContainsFold: String
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
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
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  status field predicates
  """
  status: IdeaStatus
  statusNEQ: IdeaStatus
  statusIn: [IdeaStatus!]
  statusNotIn: [IdeaStatus!]
  """
  votes field predicates
  """
  votes: Int
  votesNEQ: Int
  votesIn: [Int!]
  votesNotIn: [Int!]
  votesGT: Int
  votesGTE: Int
  votesLT: Int
  votesLTE: Int
  """
  source_url field predicates
  """
  sourceURL: String
  sourceURLNEQ: String
  sourceURLIn: [String!]
  sourceURLNotIn: [String!]
  sourceURLGT: String
  sourceURLGTE: String
  sourceURLLT: String
  sourceURLLTE: String
  sourceURLContains: String
  sourceURLHasPrefix: String
  sourceURLHasSuffix: String
  sourceURLIsNil: Boolean
  sourceURLNotNil: Boolean
  sourceURLEqualFold: String
  sourceURLContainsFold: String
  """
  converted_task_id field predicates
  """
  convertedTaskID: ID
  convertedTaskIDNEQ: ID
  convertedTaskIDIn: [ID!]
  convertedTaskIDNotIn: [ID!]
  convertedTaskIDGT: ID
  convertedTaskIDGTE: ID
  convertedTaskIDLT: ID
  convertedTaskIDLTE: ID
  convertedTaskIDContains: ID
  convertedTaskIDHasPrefix: ID
  convertedTaskIDHasSuffix: ID
  convertedTaskIDIsNil: Boolean
  convertedTaskIDNotNil: Boolean
  convertedTaskIDEqualFold: ID
  convertedTaskIDContainsFold: ID
  """
  converted_plan_id field predicates
  """
  convertedPlanID: ID
  convertedPlanIDNEQ: ID
  convertedPlanIDIn: [ID!]
  convertedPlanIDNotIn: [ID!]
  convertedPlanIDGT: ID
  convertedPlanIDGTE: ID
  convertedPlanIDLT: ID
  convertedPlanIDLTE: ID
  convertedPlanIDContains: ID
  convertedPlanIDHasPrefix: ID
  convertedPlanIDHasSuffix: ID
  convertedPlanIDIsNil: Boolean
  convertedPlanIDNotNil: Boolean
  convertedPlanIDEqualFold: ID
  convertedPlanIDContainsFold: ID
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
  """
  converted_task edge predicates
  """
  hasConvertedTask: Boolean
  hasConvertedTaskWith: [TaskWhereInput!]
  """
  converted_plan edge predicates
  """
  hasConvertedPlan: Boolean
  hasConvertedPlanWith: [PlanWhereInput!]
}
```

### `InboxFilter`  <sub>tasksystem.graphql</sub>

```graphql
input InboxFilter {
  unreadOnly: Boolean
  projectID: ID
  eventKinds: [NotificationEventKind!]
  limit: Int
}
```

### `LabelOrder`  <sub>ent.graphql</sub>

```graphql
input LabelOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Labels.
  """
  field: LabelOrderField!
}
```

### `LabelWhereInput`  <sub>ent.graphql</sub>

```graphql
input LabelWhereInput {
  not: LabelWhereInput
  and: [LabelWhereInput!]
  or: [LabelWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  color field predicates
  """
  color: String
  colorNEQ: String
  colorIn: [String!]
  colorNotIn: [String!]
  colorGT: String
  colorGTE: String
  colorLT: String
  colorLTE: String
  colorContains: String
  colorHasPrefix: String
  colorHasSuffix: String
  colorIsNil: Boolean
  colorNotNil: Boolean
  colorEqualFold: String
  colorContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
}
```

### `ListViewExcludeOrder`  <sub>ent.graphql</sub>

```graphql
input ListViewExcludeOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order ListViewExcludes.
  """
  field: ListViewExcludeOrderField!
}
```

### `ListViewExcludeWhereInput`  <sub>ent.graphql</sub>

```graphql
input ListViewExcludeWhereInput {
  not: ListViewExcludeWhereInput
  and: [ListViewExcludeWhereInput!]
  or: [ListViewExcludeWhereInput!]
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
  view_id field predicates
  """
  viewID: ID
  viewIDNEQ: ID
  viewIDIn: [ID!]
  viewIDNotIn: [ID!]
  viewIDGT: ID
  viewIDGTE: ID
  viewIDLT: ID
  viewIDLTE: ID
  viewIDContains: ID
  viewIDHasPrefix: ID
  viewIDHasSuffix: ID
  viewIDEqualFold: ID
  viewIDContainsFold: ID
  """
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  reason field predicates
  """
  reason: String
  reasonNEQ: String
  reasonIn: [String!]
  reasonNotIn: [String!]
  reasonGT: String
  reasonGTE: String
  reasonLT: String
  reasonLTE: String
  reasonContains: String
  reasonHasPrefix: String
  reasonHasSuffix: String
  reasonIsNil: Boolean
  reasonNotNil: Boolean
  reasonEqualFold: String
  reasonContainsFold: String
  """
  excluded_by_user_id field predicates
  """
  excludedByUserID: String
  excludedByUserIDNEQ: String
  excludedByUserIDIn: [String!]
  excludedByUserIDNotIn: [String!]
  excludedByUserIDGT: String
  excludedByUserIDGTE: String
  excludedByUserIDLT: String
  excludedByUserIDLTE: String
  excludedByUserIDContains: String
  excludedByUserIDHasPrefix: String
  excludedByUserIDHasSuffix: String
  excludedByUserIDIsNil: Boolean
  excludedByUserIDNotNil: Boolean
  excludedByUserIDEqualFold: String
  excludedByUserIDContainsFold: String
  """
  view edge predicates
  """
  hasView: Boolean
  hasViewWith: [ListViewWhereInput!]
}
```

### `ListViewIncludeOrder`  <sub>ent.graphql</sub>

```graphql
input ListViewIncludeOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order ListViewIncludes.
  """
  field: ListViewIncludeOrderField!
}
```

### `ListViewIncludeWhereInput`  <sub>ent.graphql</sub>

```graphql
input ListViewIncludeWhereInput {
  not: ListViewIncludeWhereInput
  and: [ListViewIncludeWhereInput!]
  or: [ListViewIncludeWhereInput!]
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
  view_id field predicates
  """
  viewID: ID
  viewIDNEQ: ID
  viewIDIn: [ID!]
  viewIDNotIn: [ID!]
  viewIDGT: ID
  viewIDGTE: ID
  viewIDLT: ID
  viewIDLTE: ID
  viewIDContains: ID
  viewIDHasPrefix: ID
  viewIDHasSuffix: ID
  viewIDEqualFold: ID
  viewIDContainsFold: ID
  """
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  added_by_user_id field predicates
  """
  addedByUserID: String
  addedByUserIDNEQ: String
  addedByUserIDIn: [String!]
  addedByUserIDNotIn: [String!]
  addedByUserIDGT: String
  addedByUserIDGTE: String
  addedByUserIDLT: String
  addedByUserIDLTE: String
  addedByUserIDContains: String
  addedByUserIDHasPrefix: String
  addedByUserIDHasSuffix: String
  addedByUserIDIsNil: Boolean
  addedByUserIDNotNil: Boolean
  addedByUserIDEqualFold: String
  addedByUserIDContainsFold: String
  """
  view edge predicates
  """
  hasView: Boolean
  hasViewWith: [ListViewWhereInput!]
}
```

### `ListViewOrder`  <sub>ent.graphql</sub>

```graphql
input ListViewOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order ListViews.
  """
  field: ListViewOrderField!
}
```

### `ListViewWhereInput`  <sub>ent.graphql</sub>

```graphql
input ListViewWhereInput {
  not: ListViewWhereInput
  and: [ListViewWhereInput!]
  or: [ListViewWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  owner_user_id field predicates
  """
  ownerUserID: String
  ownerUserIDNEQ: String
  ownerUserIDIn: [String!]
  ownerUserIDNotIn: [String!]
  ownerUserIDGT: String
  ownerUserIDGTE: String
  ownerUserIDLT: String
  ownerUserIDLTE: String
  ownerUserIDContains: String
  ownerUserIDHasPrefix: String
  ownerUserIDHasSuffix: String
  ownerUserIDEqualFold: String
  ownerUserIDContainsFold: String
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  is_seeded field predicates
  """
  isSeeded: Boolean
  isSeededNEQ: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  includes edge predicates
  """
  hasIncludes: Boolean
  hasIncludesWith: [ListViewIncludeWhereInput!]
  """
  excludes edge predicates
  """
  hasExcludes: Boolean
  hasExcludesWith: [ListViewExcludeWhereInput!]
}
```

### `MemoryOrder`  <sub>ent.graphql</sub>

```graphql
input MemoryOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Memories.
  """
  field: MemoryOrderField!
}
```

### `MemoryWhereInput`  <sub>ent.graphql</sub>

```graphql
input MemoryWhereInput {
  not: MemoryWhereInput
  and: [MemoryWhereInput!]
  or: [MemoryWhereInput!]
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
  project_id field predicates
  """
  projectID: String
  projectIDNEQ: String
  projectIDIn: [String!]
  projectIDNotIn: [String!]
  projectIDGT: String
  projectIDGTE: String
  projectIDLT: String
  projectIDLTE: String
  projectIDContains: String
  projectIDHasPrefix: String
  projectIDHasSuffix: String
  projectIDEqualFold: String
  projectIDContainsFold: String
  """
  tag field predicates
  """
  tag: MemoryTag
  tagNEQ: MemoryTag
  tagIn: [MemoryTag!]
  tagNotIn: [MemoryTag!]
  """
  status field predicates
  """
  status: MemoryStatus
  statusNEQ: MemoryStatus
  statusIn: [MemoryStatus!]
  statusNotIn: [MemoryStatus!]
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
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
  source_task_id field predicates
  """
  sourceTaskID: String
  sourceTaskIDNEQ: String
  sourceTaskIDIn: [String!]
  sourceTaskIDNotIn: [String!]
  sourceTaskIDGT: String
  sourceTaskIDGTE: String
  sourceTaskIDLT: String
  sourceTaskIDLTE: String
  sourceTaskIDContains: String
  sourceTaskIDHasPrefix: String
  sourceTaskIDHasSuffix: String
  sourceTaskIDIsNil: Boolean
  sourceTaskIDNotNil: Boolean
  sourceTaskIDEqualFold: String
  sourceTaskIDContainsFold: String
  """
  source_run_id field predicates
  """
  sourceRunID: String
  sourceRunIDNEQ: String
  sourceRunIDIn: [String!]
  sourceRunIDNotIn: [String!]
  sourceRunIDGT: String
  sourceRunIDGTE: String
  sourceRunIDLT: String
  sourceRunIDLTE: String
  sourceRunIDContains: String
  sourceRunIDHasPrefix: String
  sourceRunIDHasSuffix: String
  sourceRunIDIsNil: Boolean
  sourceRunIDNotNil: Boolean
  sourceRunIDEqualFold: String
  sourceRunIDContainsFold: String
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  created_by_agent_id field predicates
  """
  createdByAgentID: String
  createdByAgentIDNEQ: String
  createdByAgentIDIn: [String!]
  createdByAgentIDNotIn: [String!]
  createdByAgentIDGT: String
  createdByAgentIDGTE: String
  createdByAgentIDLT: String
  createdByAgentIDLTE: String
  createdByAgentIDContains: String
  createdByAgentIDHasPrefix: String
  createdByAgentIDHasSuffix: String
  createdByAgentIDIsNil: Boolean
  createdByAgentIDNotNil: Boolean
  createdByAgentIDEqualFold: String
  createdByAgentIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
}
```

### `NotificationOrder`  <sub>ent.graphql</sub>

```graphql
input NotificationOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Notifications.
  """
  field: NotificationOrderField!
}
```

### `NotificationWhereInput`  <sub>ent.graphql</sub>

```graphql
input NotificationWhereInput {
  not: NotificationWhereInput
  and: [NotificationWhereInput!]
  or: [NotificationWhereInput!]
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
  user_id field predicates
  """
  userID: String
  userIDNEQ: String
  userIDIn: [String!]
  userIDNotIn: [String!]
  userIDGT: String
  userIDGTE: String
  userIDLT: String
  userIDLTE: String
  userIDContains: String
  userIDHasPrefix: String
  userIDHasSuffix: String
  userIDEqualFold: String
  userIDContainsFold: String
  """
  event_kind field predicates
  """
  eventKind: NotificationEventKind
  eventKindNEQ: NotificationEventKind
  eventKindIn: [NotificationEventKind!]
  eventKindNotIn: [NotificationEventKind!]
  """
  project_id field predicates
  """
  projectID: String
  projectIDNEQ: String
  projectIDIn: [String!]
  projectIDNotIn: [String!]
  projectIDGT: String
  projectIDGTE: String
  projectIDLT: String
  projectIDLTE: String
  projectIDContains: String
  projectIDHasPrefix: String
  projectIDHasSuffix: String
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: String
  projectIDContainsFold: String
  """
  task_id field predicates
  """
  taskID: String
  taskIDNEQ: String
  taskIDIn: [String!]
  taskIDNotIn: [String!]
  taskIDGT: String
  taskIDGTE: String
  taskIDLT: String
  taskIDLTE: String
  taskIDContains: String
  taskIDHasPrefix: String
  taskIDHasSuffix: String
  taskIDIsNil: Boolean
  taskIDNotNil: Boolean
  taskIDEqualFold: String
  taskIDContainsFold: String
  """
  run_id field predicates
  """
  runID: String
  runIDNEQ: String
  runIDIn: [String!]
  runIDNotIn: [String!]
  runIDGT: String
  runIDGTE: String
  runIDLT: String
  runIDLTE: String
  runIDContains: String
  runIDHasPrefix: String
  runIDHasSuffix: String
  runIDIsNil: Boolean
  runIDNotNil: Boolean
  runIDEqualFold: String
  runIDContainsFold: String
  """
  gate_id field predicates
  """
  gateID: String
  gateIDNEQ: String
  gateIDIn: [String!]
  gateIDNotIn: [String!]
  gateIDGT: String
  gateIDGTE: String
  gateIDLT: String
  gateIDLTE: String
  gateIDContains: String
  gateIDHasPrefix: String
  gateIDHasSuffix: String
  gateIDIsNil: Boolean
  gateIDNotNil: Boolean
  gateIDEqualFold: String
  gateIDContainsFold: String
  """
  comment_id field predicates
  """
  commentID: String
  commentIDNEQ: String
  commentIDIn: [String!]
  commentIDNotIn: [String!]
  commentIDGT: String
  commentIDGTE: String
  commentIDLT: String
  commentIDLTE: String
  commentIDContains: String
  commentIDHasPrefix: String
  commentIDHasSuffix: String
  commentIDIsNil: Boolean
  commentIDNotNil: Boolean
  commentIDEqualFold: String
  commentIDContainsFold: String
  """
  actor_user_id field predicates
  """
  actorUserID: String
  actorUserIDNEQ: String
  actorUserIDIn: [String!]
  actorUserIDNotIn: [String!]
  actorUserIDGT: String
  actorUserIDGTE: String
  actorUserIDLT: String
  actorUserIDLTE: String
  actorUserIDContains: String
  actorUserIDHasPrefix: String
  actorUserIDHasSuffix: String
  actorUserIDIsNil: Boolean
  actorUserIDNotNil: Boolean
  actorUserIDEqualFold: String
  actorUserIDContainsFold: String
  """
  actor_agent_id field predicates
  """
  actorAgentID: String
  actorAgentIDNEQ: String
  actorAgentIDIn: [String!]
  actorAgentIDNotIn: [String!]
  actorAgentIDGT: String
  actorAgentIDGTE: String
  actorAgentIDLT: String
  actorAgentIDLTE: String
  actorAgentIDContains: String
  actorAgentIDHasPrefix: String
  actorAgentIDHasSuffix: String
  actorAgentIDIsNil: Boolean
  actorAgentIDNotNil: Boolean
  actorAgentIDEqualFold: String
  actorAgentIDContainsFold: String
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
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
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  link field predicates
  """
  link: String
  linkNEQ: String
  linkIn: [String!]
  linkNotIn: [String!]
  linkGT: String
  linkGTE: String
  linkLT: String
  linkLTE: String
  linkContains: String
  linkHasPrefix: String
  linkHasSuffix: String
  linkIsNil: Boolean
  linkNotNil: Boolean
  linkEqualFold: String
  linkContainsFold: String
  """
  read_at field predicates
  """
  readAt: Time
  readAtNEQ: Time
  readAtIn: [Time!]
  readAtNotIn: [Time!]
  readAtGT: Time
  readAtGTE: Time
  readAtLT: Time
  readAtLTE: Time
  readAtIsNil: Boolean
  readAtNotNil: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
}
```

### `PlanOrder`  <sub>ent.graphql</sub>

```graphql
input PlanOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Plans.
  """
  field: PlanOrderField!
}
```

### `PlanWhereInput`  <sub>ent.graphql</sub>

```graphql
input PlanWhereInput {
  not: PlanWhereInput
  and: [PlanWhereInput!]
  or: [PlanWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  spec_id field predicates
  """
  specID: ID
  specIDNEQ: ID
  specIDIn: [ID!]
  specIDNotIn: [ID!]
  specIDGT: ID
  specIDGTE: ID
  specIDLT: ID
  specIDLTE: ID
  specIDContains: ID
  specIDHasPrefix: ID
  specIDHasSuffix: ID
  specIDIsNil: Boolean
  specIDNotNil: Boolean
  specIDEqualFold: ID
  specIDContainsFold: ID
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  strategy field predicates
  """
  strategy: String
  strategyNEQ: String
  strategyIn: [String!]
  strategyNotIn: [String!]
  strategyGT: String
  strategyGTE: String
  strategyLT: String
  strategyLTE: String
  strategyContains: String
  strategyHasPrefix: String
  strategyHasSuffix: String
  strategyIsNil: Boolean
  strategyNotNil: Boolean
  strategyEqualFold: String
  strategyContainsFold: String
  """
  status field predicates
  """
  status: PlanStatus
  statusNEQ: PlanStatus
  statusIn: [PlanStatus!]
  statusNotIn: [PlanStatus!]
  """
  approved_by_user_id field predicates
  """
  approvedByUserID: String
  approvedByUserIDNEQ: String
  approvedByUserIDIn: [String!]
  approvedByUserIDNotIn: [String!]
  approvedByUserIDGT: String
  approvedByUserIDGTE: String
  approvedByUserIDLT: String
  approvedByUserIDLTE: String
  approvedByUserIDContains: String
  approvedByUserIDHasPrefix: String
  approvedByUserIDHasSuffix: String
  approvedByUserIDIsNil: Boolean
  approvedByUserIDNotNil: Boolean
  approvedByUserIDEqualFold: String
  approvedByUserIDContainsFold: String
  """
  approved_at field predicates
  """
  approvedAt: Time
  approvedAtNEQ: Time
  approvedAtIn: [Time!]
  approvedAtNotIn: [Time!]
  approvedAtGT: Time
  approvedAtGTE: Time
  approvedAtLT: Time
  approvedAtLTE: Time
  approvedAtIsNil: Boolean
  approvedAtNotNil: Boolean
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  spec edge predicates
  """
  hasSpec: Boolean
  hasSpecWith: [SpecWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
  """
  converted_from_ideas edge predicates
  """
  hasConvertedFromIdeas: Boolean
  hasConvertedFromIdeasWith: [IdeaWhereInput!]
}
```

### `PostReviewInput`  <sub>tasksystem.graphql</sub>

```graphql
input PostReviewInput {
  taskID: ID!
  runID: ID!
  scope: ReviewScope!
  verdict: ReviewVerdict!
  reviewerUserID: ID
  reviewerAgentID: ID
  feedback: String
  feedbackStructured: Map
}
```

### `ProjectDirectoryOrder`  <sub>ent.graphql</sub>

```graphql
input ProjectDirectoryOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order ProjectDirectories.
  """
  field: ProjectDirectoryOrderField!
}
```

### `ProjectDirectoryWhereInput`  <sub>ent.graphql</sub>

```graphql
input ProjectDirectoryWhereInput {
  not: ProjectDirectoryWhereInput
  and: [ProjectDirectoryWhereInput!]
  or: [ProjectDirectoryWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  path field predicates
  """
  path: String
  pathNEQ: String
  pathIn: [String!]
  pathNotIn: [String!]
  pathGT: String
  pathGTE: String
  pathLT: String
  pathLTE: String
  pathContains: String
  pathHasPrefix: String
  pathHasSuffix: String
  pathEqualFold: String
  pathContainsFold: String
  """
  label field predicates
  """
  label: String
  labelNEQ: String
  labelIn: [String!]
  labelNotIn: [String!]
  labelGT: String
  labelGTE: String
  labelLT: String
  labelLTE: String
  labelContains: String
  labelHasPrefix: String
  labelHasSuffix: String
  labelIsNil: Boolean
  labelNotNil: Boolean
  labelEqualFold: String
  labelContainsFold: String
  """
  is_active field predicates
  """
  isActive: Boolean
  isActiveNEQ: Boolean
  """
  sort_order field predicates
  """
  sortOrder: Int
  sortOrderNEQ: Int
  sortOrderIn: [Int!]
  sortOrderNotIn: [Int!]
  sortOrderGT: Int
  sortOrderGTE: Int
  sortOrderLT: Int
  sortOrderLTE: Int
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
}
```

### `ProjectMemberOrder`  <sub>ent.graphql</sub>

```graphql
input ProjectMemberOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order ProjectMembers.
  """
  field: ProjectMemberOrderField!
}
```

### `ProjectMemberWhereInput`  <sub>ent.graphql</sub>

```graphql
input ProjectMemberWhereInput {
  not: ProjectMemberWhereInput
  and: [ProjectMemberWhereInput!]
  or: [ProjectMemberWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  user_id field predicates
  """
  userID: ID
  userIDNEQ: ID
  userIDIn: [ID!]
  userIDNotIn: [ID!]
  userIDGT: ID
  userIDGTE: ID
  userIDLT: ID
  userIDLTE: ID
  userIDContains: ID
  userIDHasPrefix: ID
  userIDHasSuffix: ID
  userIDEqualFold: ID
  userIDContainsFold: ID
  """
  designation_id field predicates
  """
  designationID: ID
  designationIDNEQ: ID
  designationIDIn: [ID!]
  designationIDNotIn: [ID!]
  designationIDGT: ID
  designationIDGTE: ID
  designationIDLT: ID
  designationIDLTE: ID
  designationIDContains: ID
  designationIDHasPrefix: ID
  designationIDHasSuffix: ID
  designationIDEqualFold: ID
  designationIDContainsFold: ID
  """
  joined_at field predicates
  """
  joinedAt: Time
  joinedAtNEQ: Time
  joinedAtIn: [Time!]
  joinedAtNotIn: [Time!]
  joinedAtGT: Time
  joinedAtGTE: Time
  joinedAtLT: Time
  joinedAtLTE: Time
  """
  removed_at field predicates
  """
  removedAt: Time
  removedAtNEQ: Time
  removedAtIn: [Time!]
  removedAtNotIn: [Time!]
  removedAtGT: Time
  removedAtGTE: Time
  removedAtLT: Time
  removedAtLTE: Time
  removedAtIsNil: Boolean
  removedAtNotNil: Boolean
  """
  note field predicates
  """
  note: String
  noteNEQ: String
  noteIn: [String!]
  noteNotIn: [String!]
  noteGT: String
  noteGTE: String
  noteLT: String
  noteLTE: String
  noteContains: String
  noteHasPrefix: String
  noteHasSuffix: String
  noteIsNil: Boolean
  noteNotNil: Boolean
  noteEqualFold: String
  noteContainsFold: String
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  user edge predicates
  """
  hasUser: Boolean
  hasUserWith: [UserWhereInput!]
  """
  designation edge predicates
  """
  hasDesignation: Boolean
  hasDesignationWith: [DesignationWhereInput!]
}
```

### `ProjectOrder`  <sub>ent.graphql</sub>

```graphql
input ProjectOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Projects.
  """
  field: ProjectOrderField!
}
```

### `ProjectWhereInput`  <sub>ent.graphql</sub>

```graphql
input ProjectWhereInput {
  not: ProjectWhereInput
  and: [ProjectWhereInput!]
  or: [ProjectWhereInput!]
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
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  status field predicates
  """
  status: String
  statusNEQ: String
  statusIn: [String!]
  statusNotIn: [String!]
  statusGT: String
  statusGTE: String
  statusLT: String
  statusLTE: String
  statusContains: String
  statusHasPrefix: String
  statusHasSuffix: String
  statusEqualFold: String
  statusContainsFold: String
  """
  directories edge predicates
  """
  hasDirectories: Boolean
  hasDirectoriesWith: [ProjectDirectoryWhereInput!]
  """
  workspace_layouts edge predicates
  """
  hasWorkspaceLayouts: Boolean
  hasWorkspaceLayoutsWith: [WorkspaceLayoutWhereInput!]
  """
  boards edge predicates
  """
  hasBoards: Boolean
  hasBoardsWith: [BoardWhereInput!]
  """
  tasks edge predicates
  """
  hasTasks: Boolean
  hasTasksWith: [TaskWhereInput!]
  """
  labels edge predicates
  """
  hasLabels: Boolean
  hasLabelsWith: [LabelWhereInput!]
  """
  task_lists edge predicates
  """
  hasTaskLists: Boolean
  hasTaskListsWith: [TaskListWhereInput!]
  """
  specs edge predicates
  """
  hasSpecs: Boolean
  hasSpecsWith: [SpecWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  ideas edge predicates
  """
  hasIdeas: Boolean
  hasIdeasWith: [IdeaWhereInput!]
  """
  areas edge predicates
  """
  hasAreas: Boolean
  hasAreasWith: [AreaWhereInput!]
  """
  sources edge predicates
  """
  hasSources: Boolean
  hasSourcesWith: [SourceWhereInput!]
  """
  scratches edge predicates
  """
  hasScratches: Boolean
  hasScratchesWith: [ScratchWhereInput!]
  """
  members edge predicates
  """
  hasMembers: Boolean
  hasMembersWith: [ProjectMemberWhereInput!]
  """
  list_views edge predicates
  """
  hasListViews: Boolean
  hasListViewsWith: [ListViewWhereInput!]
}
```

### `RequestGateInput`  <sub>tasksystem.graphql</sub>

```graphql
input RequestGateInput {
  taskID: ID!
  runID: ID
  reason: String!
  context: Map
}
```

### `ReviewOrder`  <sub>ent.graphql</sub>

```graphql
input ReviewOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Reviews.
  """
  field: ReviewOrderField!
}
```

### `ReviewWhereInput`  <sub>ent.graphql</sub>

```graphql
input ReviewWhereInput {
  not: ReviewWhereInput
  and: [ReviewWhereInput!]
  or: [ReviewWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  run_id field predicates
  """
  runID: ID
  runIDNEQ: ID
  runIDIn: [ID!]
  runIDNotIn: [ID!]
  runIDGT: ID
  runIDGTE: ID
  runIDLT: ID
  runIDLTE: ID
  runIDContains: ID
  runIDHasPrefix: ID
  runIDHasSuffix: ID
  runIDEqualFold: ID
  runIDContainsFold: ID
  """
  scope field predicates
  """
  scope: ReviewScope
  scopeNEQ: ReviewScope
  scopeIn: [ReviewScope!]
  scopeNotIn: [ReviewScope!]
  """
  verdict field predicates
  """
  verdict: ReviewVerdict
  verdictNEQ: ReviewVerdict
  verdictIn: [ReviewVerdict!]
  verdictNotIn: [ReviewVerdict!]
  """
  reviewer_user_id field predicates
  """
  reviewerUserID: String
  reviewerUserIDNEQ: String
  reviewerUserIDIn: [String!]
  reviewerUserIDNotIn: [String!]
  reviewerUserIDGT: String
  reviewerUserIDGTE: String
  reviewerUserIDLT: String
  reviewerUserIDLTE: String
  reviewerUserIDContains: String
  reviewerUserIDHasPrefix: String
  reviewerUserIDHasSuffix: String
  reviewerUserIDIsNil: Boolean
  reviewerUserIDNotNil: Boolean
  reviewerUserIDEqualFold: String
  reviewerUserIDContainsFold: String
  """
  reviewer_agent_id field predicates
  """
  reviewerAgentID: String
  reviewerAgentIDNEQ: String
  reviewerAgentIDIn: [String!]
  reviewerAgentIDNotIn: [String!]
  reviewerAgentIDGT: String
  reviewerAgentIDGTE: String
  reviewerAgentIDLT: String
  reviewerAgentIDLTE: String
  reviewerAgentIDContains: String
  reviewerAgentIDHasPrefix: String
  reviewerAgentIDHasSuffix: String
  reviewerAgentIDIsNil: Boolean
  reviewerAgentIDNotNil: Boolean
  reviewerAgentIDEqualFold: String
  reviewerAgentIDContainsFold: String
  """
  feedback field predicates
  """
  feedback: String
  feedbackNEQ: String
  feedbackIn: [String!]
  feedbackNotIn: [String!]
  feedbackGT: String
  feedbackGTE: String
  feedbackLT: String
  feedbackLTE: String
  feedbackContains: String
  feedbackHasPrefix: String
  feedbackHasSuffix: String
  feedbackIsNil: Boolean
  feedbackNotNil: Boolean
  feedbackEqualFold: String
  feedbackContainsFold: String
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
  """
  run edge predicates
  """
  hasRun: Boolean
  hasRunWith: [RunWhereInput!]
}
```

### `RunOrder`  <sub>ent.graphql</sub>

```graphql
input RunOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Runs.
  """
  field: RunOrderField!
}
```

### `RunStepInput`  <sub>tasksystem.graphql</sub>

```graphql
input RunStepInput {
  title: String!
  rationale: String
  expectedOutput: Map
  position: Float
}
```

### `RunStepOrder`  <sub>ent.graphql</sub>

```graphql
input RunStepOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order RunSteps.
  """
  field: RunStepOrderField!
}
```

### `RunStepWhereInput`  <sub>ent.graphql</sub>

```graphql
input RunStepWhereInput {
  not: RunStepWhereInput
  and: [RunStepWhereInput!]
  or: [RunStepWhereInput!]
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
  run_id field predicates
  """
  runID: ID
  runIDNEQ: ID
  runIDIn: [ID!]
  runIDNotIn: [ID!]
  runIDGT: ID
  runIDGTE: ID
  runIDLT: ID
  runIDLTE: ID
  runIDContains: ID
  runIDHasPrefix: ID
  runIDHasSuffix: ID
  runIDEqualFold: ID
  runIDContainsFold: ID
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  rationale field predicates
  """
  rationale: String
  rationaleNEQ: String
  rationaleIn: [String!]
  rationaleNotIn: [String!]
  rationaleGT: String
  rationaleGTE: String
  rationaleLT: String
  rationaleLTE: String
  rationaleContains: String
  rationaleHasPrefix: String
  rationaleHasSuffix: String
  rationaleIsNil: Boolean
  rationaleNotNil: Boolean
  rationaleEqualFold: String
  rationaleContainsFold: String
  """
  status field predicates
  """
  status: RunStepStatus
  statusNEQ: RunStepStatus
  statusIn: [RunStepStatus!]
  statusNotIn: [RunStepStatus!]
  """
  blocked_reason field predicates
  """
  blockedReason: String
  blockedReasonNEQ: String
  blockedReasonIn: [String!]
  blockedReasonNotIn: [String!]
  blockedReasonGT: String
  blockedReasonGTE: String
  blockedReasonLT: String
  blockedReasonLTE: String
  blockedReasonContains: String
  blockedReasonHasPrefix: String
  blockedReasonHasSuffix: String
  blockedReasonIsNil: Boolean
  blockedReasonNotNil: Boolean
  blockedReasonEqualFold: String
  blockedReasonContainsFold: String
  """
  started_at field predicates
  """
  startedAt: Time
  startedAtNEQ: Time
  startedAtIn: [Time!]
  startedAtNotIn: [Time!]
  startedAtGT: Time
  startedAtGTE: Time
  startedAtLT: Time
  startedAtLTE: Time
  startedAtIsNil: Boolean
  startedAtNotNil: Boolean
  """
  finished_at field predicates
  """
  finishedAt: Time
  finishedAtNEQ: Time
  finishedAtIn: [Time!]
  finishedAtNotIn: [Time!]
  finishedAtGT: Time
  finishedAtGTE: Time
  finishedAtLT: Time
  finishedAtLTE: Time
  finishedAtIsNil: Boolean
  finishedAtNotNil: Boolean
  """
  notes field predicates
  """
  notes: String
  notesNEQ: String
  notesIn: [String!]
  notesNotIn: [String!]
  notesGT: String
  notesGTE: String
  notesLT: String
  notesLTE: String
  notesContains: String
  notesHasPrefix: String
  notesHasSuffix: String
  notesIsNil: Boolean
  notesNotNil: Boolean
  notesEqualFold: String
  notesContainsFold: String
  """
  error_message field predicates
  """
  errorMessage: String
  errorMessageNEQ: String
  errorMessageIn: [String!]
  errorMessageNotIn: [String!]
  errorMessageGT: String
  errorMessageGTE: String
  errorMessageLT: String
  errorMessageLTE: String
  errorMessageContains: String
  errorMessageHasPrefix: String
  errorMessageHasSuffix: String
  errorMessageIsNil: Boolean
  errorMessageNotNil: Boolean
  errorMessageEqualFold: String
  errorMessageContainsFold: String
  """
  run edge predicates
  """
  hasRun: Boolean
  hasRunWith: [RunWhereInput!]
}
```

### `RunWhereInput`  <sub>ent.graphql</sub>

```graphql
input RunWhereInput {
  not: RunWhereInput
  and: [RunWhereInput!]
  or: [RunWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  agent_id field predicates
  """
  agentID: String
  agentIDNEQ: String
  agentIDIn: [String!]
  agentIDNotIn: [String!]
  agentIDGT: String
  agentIDGTE: String
  agentIDLT: String
  agentIDLTE: String
  agentIDContains: String
  agentIDHasPrefix: String
  agentIDHasSuffix: String
  agentIDIsNil: Boolean
  agentIDNotNil: Boolean
  agentIDEqualFold: String
  agentIDContainsFold: String
  """
  attempt field predicates
  """
  attempt: Int
  attemptNEQ: Int
  attemptIn: [Int!]
  attemptNotIn: [Int!]
  attemptGT: Int
  attemptGTE: Int
  attemptLT: Int
  attemptLTE: Int
  """
  outcome field predicates
  """
  outcome: RunOutcome
  outcomeNEQ: RunOutcome
  outcomeIn: [RunOutcome!]
  outcomeNotIn: [RunOutcome!]
  """
  error_kind field predicates
  """
  errorKind: String
  errorKindNEQ: String
  errorKindIn: [String!]
  errorKindNotIn: [String!]
  errorKindGT: String
  errorKindGTE: String
  errorKindLT: String
  errorKindLTE: String
  errorKindContains: String
  errorKindHasPrefix: String
  errorKindHasSuffix: String
  errorKindIsNil: Boolean
  errorKindNotNil: Boolean
  errorKindEqualFold: String
  errorKindContainsFold: String
  """
  error_message field predicates
  """
  errorMessage: String
  errorMessageNEQ: String
  errorMessageIn: [String!]
  errorMessageNotIn: [String!]
  errorMessageGT: String
  errorMessageGTE: String
  errorMessageLT: String
  errorMessageLTE: String
  errorMessageContains: String
  errorMessageHasPrefix: String
  errorMessageHasSuffix: String
  errorMessageIsNil: Boolean
  errorMessageNotNil: Boolean
  errorMessageEqualFold: String
  errorMessageContainsFold: String
  """
  output_valid field predicates
  """
  outputValid: Boolean
  outputValidNEQ: Boolean
  outputValidIsNil: Boolean
  outputValidNotNil: Boolean
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
  """
  approach field predicates
  """
  approach: String
  approachNEQ: String
  approachIn: [String!]
  approachNotIn: [String!]
  approachGT: String
  approachGTE: String
  approachLT: String
  approachLTE: String
  approachContains: String
  approachHasPrefix: String
  approachHasSuffix: String
  approachIsNil: Boolean
  approachNotNil: Boolean
  approachEqualFold: String
  approachContainsFold: String
  """
  reasoning field predicates
  """
  reasoning: String
  reasoningNEQ: String
  reasoningIn: [String!]
  reasoningNotIn: [String!]
  reasoningGT: String
  reasoningGTE: String
  reasoningLT: String
  reasoningLTE: String
  reasoningContains: String
  reasoningHasPrefix: String
  reasoningHasSuffix: String
  reasoningIsNil: Boolean
  reasoningNotNil: Boolean
  reasoningEqualFold: String
  reasoningContainsFold: String
  """
  reasoning_attachment_id field predicates
  """
  reasoningAttachmentID: String
  reasoningAttachmentIDNEQ: String
  reasoningAttachmentIDIn: [String!]
  reasoningAttachmentIDNotIn: [String!]
  reasoningAttachmentIDGT: String
  reasoningAttachmentIDGTE: String
  reasoningAttachmentIDLT: String
  reasoningAttachmentIDLTE: String
  reasoningAttachmentIDContains: String
  reasoningAttachmentIDHasPrefix: String
  reasoningAttachmentIDHasSuffix: String
  reasoningAttachmentIDIsNil: Boolean
  reasoningAttachmentIDNotNil: Boolean
  reasoningAttachmentIDEqualFold: String
  reasoningAttachmentIDContainsFold: String
  """
  confidence field predicates
  """
  confidence: RunConfidence
  confidenceNEQ: RunConfidence
  confidenceIn: [RunConfidence!]
  confidenceNotIn: [RunConfidence!]
  confidenceIsNil: Boolean
  confidenceNotNil: Boolean
  """
  model field predicates
  """
  model: String
  modelNEQ: String
  modelIn: [String!]
  modelNotIn: [String!]
  modelGT: String
  modelGTE: String
  modelLT: String
  modelLTE: String
  modelContains: String
  modelHasPrefix: String
  modelHasSuffix: String
  modelIsNil: Boolean
  modelNotNil: Boolean
  modelEqualFold: String
  modelContainsFold: String
  """
  tokens_in field predicates
  """
  tokensIn: Int
  tokensInNEQ: Int
  tokensInIn: [Int!]
  tokensInNotIn: [Int!]
  tokensInGT: Int
  tokensInGTE: Int
  tokensInLT: Int
  tokensInLTE: Int
  tokensInIsNil: Boolean
  tokensInNotNil: Boolean
  """
  tokens_out field predicates
  """
  tokensOut: Int
  tokensOutNEQ: Int
  tokensOutIn: [Int!]
  tokensOutNotIn: [Int!]
  tokensOutGT: Int
  tokensOutGTE: Int
  tokensOutLT: Int
  tokensOutLTE: Int
  tokensOutIsNil: Boolean
  tokensOutNotNil: Boolean
  """
  cost_usd field predicates
  """
  costUsd: Float
  costUsdNEQ: Float
  costUsdIn: [Float!]
  costUsdNotIn: [Float!]
  costUsdGT: Float
  costUsdGTE: Float
  costUsdLT: Float
  costUsdLTE: Float
  costUsdIsNil: Boolean
  costUsdNotNil: Boolean
  """
  duration_ms field predicates
  """
  durationMs: Int
  durationMsNEQ: Int
  durationMsIn: [Int!]
  durationMsNotIn: [Int!]
  durationMsGT: Int
  durationMsGTE: Int
  durationMsLT: Int
  durationMsLTE: Int
  durationMsIsNil: Boolean
  durationMsNotNil: Boolean
  """
  git_commit_sha field predicates
  """
  gitCommitSha: String
  gitCommitShaNEQ: String
  gitCommitShaIn: [String!]
  gitCommitShaNotIn: [String!]
  gitCommitShaGT: String
  gitCommitShaGTE: String
  gitCommitShaLT: String
  gitCommitShaLTE: String
  gitCommitShaContains: String
  gitCommitShaHasPrefix: String
  gitCommitShaHasSuffix: String
  gitCommitShaIsNil: Boolean
  gitCommitShaNotNil: Boolean
  gitCommitShaEqualFold: String
  gitCommitShaContainsFold: String
  """
  plan_status field predicates
  """
  planStatus: RunPlanStatus
  planStatusNEQ: RunPlanStatus
  planStatusIn: [RunPlanStatus!]
  planStatusNotIn: [RunPlanStatus!]
  """
  plan_summary field predicates
  """
  planSummary: String
  planSummaryNEQ: String
  planSummaryIn: [String!]
  planSummaryNotIn: [String!]
  planSummaryGT: String
  planSummaryGTE: String
  planSummaryLT: String
  planSummaryLTE: String
  planSummaryContains: String
  planSummaryHasPrefix: String
  planSummaryHasSuffix: String
  planSummaryIsNil: Boolean
  planSummaryNotNil: Boolean
  planSummaryEqualFold: String
  planSummaryContainsFold: String
  """
  plan_approved_by_user_id field predicates
  """
  planApprovedByUserID: String
  planApprovedByUserIDNEQ: String
  planApprovedByUserIDIn: [String!]
  planApprovedByUserIDNotIn: [String!]
  planApprovedByUserIDGT: String
  planApprovedByUserIDGTE: String
  planApprovedByUserIDLT: String
  planApprovedByUserIDLTE: String
  planApprovedByUserIDContains: String
  planApprovedByUserIDHasPrefix: String
  planApprovedByUserIDHasSuffix: String
  planApprovedByUserIDIsNil: Boolean
  planApprovedByUserIDNotNil: Boolean
  planApprovedByUserIDEqualFold: String
  planApprovedByUserIDContainsFold: String
  """
  plan_approved_at field predicates
  """
  planApprovedAt: Time
  planApprovedAtNEQ: Time
  planApprovedAtIn: [Time!]
  planApprovedAtNotIn: [Time!]
  planApprovedAtGT: Time
  planApprovedAtGTE: Time
  planApprovedAtLT: Time
  planApprovedAtLTE: Time
  planApprovedAtIsNil: Boolean
  planApprovedAtNotNil: Boolean
  """
  plan_rejected_at field predicates
  """
  planRejectedAt: Time
  planRejectedAtNEQ: Time
  planRejectedAtIn: [Time!]
  planRejectedAtNotIn: [Time!]
  planRejectedAtGT: Time
  planRejectedAtGTE: Time
  planRejectedAtLT: Time
  planRejectedAtLTE: Time
  planRejectedAtIsNil: Boolean
  planRejectedAtNotNil: Boolean
  """
  plan_feedback field predicates
  """
  planFeedback: String
  planFeedbackNEQ: String
  planFeedbackIn: [String!]
  planFeedbackNotIn: [String!]
  planFeedbackGT: String
  planFeedbackGTE: String
  planFeedbackLT: String
  planFeedbackLTE: String
  planFeedbackContains: String
  planFeedbackHasPrefix: String
  planFeedbackHasSuffix: String
  planFeedbackIsNil: Boolean
  planFeedbackNotNil: Boolean
  planFeedbackEqualFold: String
  planFeedbackContainsFold: String
  """
  started_at field predicates
  """
  startedAt: Time
  startedAtNEQ: Time
  startedAtIn: [Time!]
  startedAtNotIn: [Time!]
  startedAtGT: Time
  startedAtGTE: Time
  startedAtLT: Time
  startedAtLTE: Time
  startedAtIsNil: Boolean
  startedAtNotNil: Boolean
  """
  ended_at field predicates
  """
  endedAt: Time
  endedAtNEQ: Time
  endedAtIn: [Time!]
  endedAtNotIn: [Time!]
  endedAtGT: Time
  endedAtGTE: Time
  endedAtLT: Time
  endedAtLTE: Time
  endedAtIsNil: Boolean
  endedAtNotNil: Boolean
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
  """
  steps edge predicates
  """
  hasSteps: Boolean
  hasStepsWith: [RunStepWhereInput!]
  """
  reviews edge predicates
  """
  hasReviews: Boolean
  hasReviewsWith: [ReviewWhereInput!]
}
```

### `SaveWorkspaceLayoutInput`  <sub>workspace_layout.graphql</sub>

```graphql
input SaveWorkspaceLayoutInput {
  projectId: ID!
  name: String!
  isDefault: Boolean
  spec: Map!
}
```

### `ScratchOrder`  <sub>ent.graphql</sub>

```graphql
input ScratchOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Scratches.
  """
  field: ScratchOrderField!
}
```

### `ScratchWhereInput`  <sub>ent.graphql</sub>

```graphql
input ScratchWhereInput {
  not: ScratchWhereInput
  and: [ScratchWhereInput!]
  or: [ScratchWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleIsNil: Boolean
  titleNotNil: Boolean
  titleEqualFold: String
  titleContainsFold: String
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
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  language field predicates
  """
  language: String
  languageNEQ: String
  languageIn: [String!]
  languageNotIn: [String!]
  languageGT: String
  languageGTE: String
  languageLT: String
  languageLTE: String
  languageContains: String
  languageHasPrefix: String
  languageHasSuffix: String
  languageIsNil: Boolean
  languageNotNil: Boolean
  languageEqualFold: String
  languageContainsFold: String
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
}
```

### `SourceOrder`  <sub>ent.graphql</sub>

```graphql
input SourceOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Sources.
  """
  field: SourceOrderField!
}
```

### `SourceWhereInput`  <sub>ent.graphql</sub>

```graphql
input SourceWhereInput {
  not: SourceWhereInput
  and: [SourceWhereInput!]
  or: [SourceWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  kind field predicates
  """
  kind: SourceKind
  kindNEQ: SourceKind
  kindIn: [SourceKind!]
  kindNotIn: [SourceKind!]
  """
  body_format field predicates
  """
  bodyFormat: SourceBodyFormat
  bodyFormatNEQ: SourceBodyFormat
  bodyFormatIn: [SourceBodyFormat!]
  bodyFormatNotIn: [SourceBodyFormat!]
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
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
  bodyIsNil: Boolean
  bodyNotNil: Boolean
  bodyEqualFold: String
  bodyContainsFold: String
  """
  external_url field predicates
  """
  externalURL: String
  externalURLNEQ: String
  externalURLIn: [String!]
  externalURLNotIn: [String!]
  externalURLGT: String
  externalURLGTE: String
  externalURLLT: String
  externalURLLTE: String
  externalURLContains: String
  externalURLHasPrefix: String
  externalURLHasSuffix: String
  externalURLIsNil: Boolean
  externalURLNotNil: Boolean
  externalURLEqualFold: String
  externalURLContainsFold: String
  """
  file_id field predicates
  """
  fileID: String
  fileIDNEQ: String
  fileIDIn: [String!]
  fileIDNotIn: [String!]
  fileIDGT: String
  fileIDGTE: String
  fileIDLT: String
  fileIDLTE: String
  fileIDContains: String
  fileIDHasPrefix: String
  fileIDHasSuffix: String
  fileIDIsNil: Boolean
  fileIDNotNil: Boolean
  fileIDEqualFold: String
  fileIDContainsFold: String
  """
  mime field predicates
  """
  mime: String
  mimeNEQ: String
  mimeIn: [String!]
  mimeNotIn: [String!]
  mimeGT: String
  mimeGTE: String
  mimeLT: String
  mimeLTE: String
  mimeContains: String
  mimeHasPrefix: String
  mimeHasSuffix: String
  mimeIsNil: Boolean
  mimeNotNil: Boolean
  mimeEqualFold: String
  mimeContainsFold: String
  """
  captured_by_user_id field predicates
  """
  capturedByUserID: String
  capturedByUserIDNEQ: String
  capturedByUserIDIn: [String!]
  capturedByUserIDNotIn: [String!]
  capturedByUserIDGT: String
  capturedByUserIDGTE: String
  capturedByUserIDLT: String
  capturedByUserIDLTE: String
  capturedByUserIDContains: String
  capturedByUserIDHasPrefix: String
  capturedByUserIDHasSuffix: String
  capturedByUserIDIsNil: Boolean
  capturedByUserIDNotNil: Boolean
  capturedByUserIDEqualFold: String
  capturedByUserIDContainsFold: String
  """
  captured_by_agent_id field predicates
  """
  capturedByAgentID: String
  capturedByAgentIDNEQ: String
  capturedByAgentIDIn: [String!]
  capturedByAgentIDNotIn: [String!]
  capturedByAgentIDGT: String
  capturedByAgentIDGTE: String
  capturedByAgentIDLT: String
  capturedByAgentIDLTE: String
  capturedByAgentIDContains: String
  capturedByAgentIDHasPrefix: String
  capturedByAgentIDHasSuffix: String
  capturedByAgentIDIsNil: Boolean
  capturedByAgentIDNotNil: Boolean
  capturedByAgentIDEqualFold: String
  capturedByAgentIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
}
```

### `SpecOrder`  <sub>ent.graphql</sub>

```graphql
input SpecOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Specs.
  """
  field: SpecOrderField!
}
```

### `SpecWhereInput`  <sub>ent.graphql</sub>

```graphql
input SpecWhereInput {
  not: SpecWhereInput
  and: [SpecWhereInput!]
  or: [SpecWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  summary field predicates
  """
  summary: String
  summaryNEQ: String
  summaryIn: [String!]
  summaryNotIn: [String!]
  summaryGT: String
  summaryGTE: String
  summaryLT: String
  summaryLTE: String
  summaryContains: String
  summaryHasPrefix: String
  summaryHasSuffix: String
  summaryIsNil: Boolean
  summaryNotNil: Boolean
  summaryEqualFold: String
  summaryContainsFold: String
  """
  problem field predicates
  """
  problem: String
  problemNEQ: String
  problemIn: [String!]
  problemNotIn: [String!]
  problemGT: String
  problemGTE: String
  problemLT: String
  problemLTE: String
  problemContains: String
  problemHasPrefix: String
  problemHasSuffix: String
  problemIsNil: Boolean
  problemNotNil: Boolean
  problemEqualFold: String
  problemContainsFold: String
  """
  status field predicates
  """
  status: SpecStatus
  statusNEQ: SpecStatus
  statusIn: [SpecStatus!]
  statusNotIn: [SpecStatus!]
  """
  version field predicates
  """
  version: Int
  versionNEQ: Int
  versionIn: [Int!]
  versionNotIn: [Int!]
  versionGT: Int
  versionGTE: Int
  versionLT: Int
  versionLTE: Int
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
}
```

### `StartRunInput`  <sub>tasksystem.graphql</sub>

```graphql
input StartRunInput {
  taskID: ID!
  agentID: ID
  model: String
}
```

### `TagOrder`  <sub>ent.graphql</sub>

```graphql
input TagOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Tags.
  """
  field: TagOrderField!
}
```

### `TagWhereInput`  <sub>ent.graphql</sub>

```graphql
input TagWhereInput {
  not: TagWhereInput
  and: [TagWhereInput!]
  or: [TagWhereInput!]
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
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  name_lower field predicates
  """
  nameLower: String
  nameLowerNEQ: String
  nameLowerIn: [String!]
  nameLowerNotIn: [String!]
  nameLowerGT: String
  nameLowerGTE: String
  nameLowerLT: String
  nameLowerLTE: String
  nameLowerContains: String
  nameLowerHasPrefix: String
  nameLowerHasSuffix: String
  nameLowerEqualFold: String
  nameLowerContainsFold: String
  """
  color field predicates
  """
  color: String
  colorNEQ: String
  colorIn: [String!]
  colorNotIn: [String!]
  colorGT: String
  colorGTE: String
  colorLT: String
  colorLTE: String
  colorContains: String
  colorHasPrefix: String
  colorHasSuffix: String
  colorIsNil: Boolean
  colorNotNil: Boolean
  colorEqualFold: String
  colorContainsFold: String
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  taggables edge predicates
  """
  hasTaggables: Boolean
  hasTaggablesWith: [TaggableWhereInput!]
}
```

### `TaggableOrder`  <sub>ent.graphql</sub>

```graphql
input TaggableOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Taggables.
  """
  field: TaggableOrderField!
}
```

### `TaggableWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaggableWhereInput {
  not: TaggableWhereInput
  and: [TaggableWhereInput!]
  or: [TaggableWhereInput!]
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
  taggable_id field predicates
  """
  taggableID: String
  taggableIDNEQ: String
  taggableIDIn: [String!]
  taggableIDNotIn: [String!]
  taggableIDGT: String
  taggableIDGTE: String
  taggableIDLT: String
  taggableIDLTE: String
  taggableIDContains: String
  taggableIDHasPrefix: String
  taggableIDHasSuffix: String
  taggableIDIsNil: Boolean
  taggableIDNotNil: Boolean
  taggableIDEqualFold: String
  taggableIDContainsFold: String
  """
  taggable_type field predicates
  """
  taggableType: String
  taggableTypeNEQ: String
  taggableTypeIn: [String!]
  taggableTypeNotIn: [String!]
  taggableTypeGT: String
  taggableTypeGTE: String
  taggableTypeLT: String
  taggableTypeLTE: String
  taggableTypeContains: String
  taggableTypeHasPrefix: String
  taggableTypeHasSuffix: String
  taggableTypeIsNil: Boolean
  taggableTypeNotNil: Boolean
  taggableTypeEqualFold: String
  taggableTypeContainsFold: String
  """
  tag_id field predicates
  """
  tagID: ID
  tagIDNEQ: ID
  tagIDIn: [ID!]
  tagIDNotIn: [ID!]
  tagIDGT: ID
  tagIDGTE: ID
  tagIDLT: ID
  tagIDLTE: ID
  tagIDContains: ID
  tagIDHasPrefix: ID
  tagIDHasSuffix: ID
  tagIDEqualFold: ID
  tagIDContainsFold: ID
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  created_by_agent_id field predicates
  """
  createdByAgentID: String
  createdByAgentIDNEQ: String
  createdByAgentIDIn: [String!]
  createdByAgentIDNotIn: [String!]
  createdByAgentIDGT: String
  createdByAgentIDGTE: String
  createdByAgentIDLT: String
  createdByAgentIDLTE: String
  createdByAgentIDContains: String
  createdByAgentIDHasPrefix: String
  createdByAgentIDHasSuffix: String
  createdByAgentIDIsNil: Boolean
  createdByAgentIDNotNil: Boolean
  createdByAgentIDEqualFold: String
  createdByAgentIDContainsFold: String
  """
  tag edge predicates
  """
  hasTag: Boolean
  hasTagWith: [TagWhereInput!]
}
```

### `TaskAssigneeOrder`  <sub>ent.graphql</sub>

```graphql
input TaskAssigneeOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order TaskAssignees.
  """
  field: TaskAssigneeOrderField!
}
```

### `TaskAssigneeWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaskAssigneeWhereInput {
  not: TaskAssigneeWhereInput
  and: [TaskAssigneeWhereInput!]
  or: [TaskAssigneeWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  user_id field predicates
  """
  userID: ID
  userIDNEQ: ID
  userIDIn: [ID!]
  userIDNotIn: [ID!]
  userIDGT: ID
  userIDGTE: ID
  userIDLT: ID
  userIDLTE: ID
  userIDContains: ID
  userIDHasPrefix: ID
  userIDHasSuffix: ID
  userIDEqualFold: ID
  userIDContainsFold: ID
  """
  assigned_at field predicates
  """
  assignedAt: Time
  assignedAtNEQ: Time
  assignedAtIn: [Time!]
  assignedAtNotIn: [Time!]
  assignedAtGT: Time
  assignedAtGTE: Time
  assignedAtLT: Time
  assignedAtLTE: Time
  """
  assigned_by_user_id field predicates
  """
  assignedByUserID: String
  assignedByUserIDNEQ: String
  assignedByUserIDIn: [String!]
  assignedByUserIDNotIn: [String!]
  assignedByUserIDGT: String
  assignedByUserIDGTE: String
  assignedByUserIDLT: String
  assignedByUserIDLTE: String
  assignedByUserIDContains: String
  assignedByUserIDHasPrefix: String
  assignedByUserIDHasSuffix: String
  assignedByUserIDIsNil: Boolean
  assignedByUserIDNotNil: Boolean
  assignedByUserIDEqualFold: String
  assignedByUserIDContainsFold: String
  """
  unassigned_at field predicates
  """
  unassignedAt: Time
  unassignedAtNEQ: Time
  unassignedAtIn: [Time!]
  unassignedAtNotIn: [Time!]
  unassignedAtGT: Time
  unassignedAtGTE: Time
  unassignedAtLT: Time
  unassignedAtLTE: Time
  unassignedAtIsNil: Boolean
  unassignedAtNotNil: Boolean
  """
  note field predicates
  """
  note: String
  noteNEQ: String
  noteIn: [String!]
  noteNotIn: [String!]
  noteGT: String
  noteGTE: String
  noteLT: String
  noteLTE: String
  noteContains: String
  noteHasPrefix: String
  noteHasSuffix: String
  noteIsNil: Boolean
  noteNotNil: Boolean
  noteEqualFold: String
  noteContainsFold: String
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
  """
  user edge predicates
  """
  hasUser: Boolean
  hasUserWith: [UserWhereInput!]
}
```

### `TaskLinkOrder`  <sub>ent.graphql</sub>

```graphql
input TaskLinkOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order TaskLinks.
  """
  field: TaskLinkOrderField!
}
```

### `TaskLinkWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaskLinkWhereInput {
  not: TaskLinkWhereInput
  and: [TaskLinkWhereInput!]
  or: [TaskLinkWhereInput!]
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
  task_id field predicates
  """
  taskID: ID
  taskIDNEQ: ID
  taskIDIn: [ID!]
  taskIDNotIn: [ID!]
  taskIDGT: ID
  taskIDGTE: ID
  taskIDLT: ID
  taskIDLTE: ID
  taskIDContains: ID
  taskIDHasPrefix: ID
  taskIDHasSuffix: ID
  taskIDEqualFold: ID
  taskIDContainsFold: ID
  """
  target_task_id field predicates
  """
  targetTaskID: String
  targetTaskIDNEQ: String
  targetTaskIDIn: [String!]
  targetTaskIDNotIn: [String!]
  targetTaskIDGT: String
  targetTaskIDGTE: String
  targetTaskIDLT: String
  targetTaskIDLTE: String
  targetTaskIDContains: String
  targetTaskIDHasPrefix: String
  targetTaskIDHasSuffix: String
  targetTaskIDEqualFold: String
  targetTaskIDContainsFold: String
  """
  kind field predicates
  """
  kind: TaskLinkKind
  kindNEQ: TaskLinkKind
  kindIn: [TaskLinkKind!]
  kindNotIn: [TaskLinkKind!]
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  created_by_agent_id field predicates
  """
  createdByAgentID: String
  createdByAgentIDNEQ: String
  createdByAgentIDIn: [String!]
  createdByAgentIDNotIn: [String!]
  createdByAgentIDGT: String
  createdByAgentIDGTE: String
  createdByAgentIDLT: String
  createdByAgentIDLTE: String
  createdByAgentIDContains: String
  createdByAgentIDHasPrefix: String
  createdByAgentIDHasSuffix: String
  createdByAgentIDIsNil: Boolean
  createdByAgentIDNotNil: Boolean
  createdByAgentIDEqualFold: String
  createdByAgentIDContainsFold: String
  """
  task edge predicates
  """
  hasTask: Boolean
  hasTaskWith: [TaskWhereInput!]
}
```

### `TaskListOrder`  <sub>ent.graphql</sub>

```graphql
input TaskListOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order TaskLists.
  """
  field: TaskListOrderField!
}
```

### `TaskListWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaskListWhereInput {
  not: TaskListWhereInput
  and: [TaskListWhereInput!]
  or: [TaskListWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  owner_user_id field predicates
  """
  ownerUserID: String
  ownerUserIDNEQ: String
  ownerUserIDIn: [String!]
  ownerUserIDNotIn: [String!]
  ownerUserIDGT: String
  ownerUserIDGTE: String
  ownerUserIDLT: String
  ownerUserIDLTE: String
  ownerUserIDContains: String
  ownerUserIDHasPrefix: String
  ownerUserIDHasSuffix: String
  ownerUserIDEqualFold: String
  ownerUserIDContainsFold: String
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  visibility field predicates
  """
  visibility: TaskListVisibility
  visibilityNEQ: TaskListVisibility
  visibilityIn: [TaskListVisibility!]
  visibilityNotIn: [TaskListVisibility!]
  """
  is_seeded field predicates
  """
  isSeeded: Boolean
  isSeededNEQ: Boolean
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  pinned field predicates
  """
  pinned: Boolean
  pinnedNEQ: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  owned_tasks edge predicates
  """
  hasOwnedTasks: Boolean
  hasOwnedTasksWith: [TaskWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
}
```

### `TaskOrder`  <sub>ent.graphql</sub>

```graphql
input TaskOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Tasks.
  """
  field: TaskOrderField!
}
```

### `TaskTemplateOrder`  <sub>ent.graphql</sub>

```graphql
input TaskTemplateOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order TaskTemplates.
  """
  field: TaskTemplateOrderField!
}
```

### `TaskTemplateWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaskTemplateWhereInput {
  not: TaskTemplateWhereInput
  and: [TaskTemplateWhereInput!]
  or: [TaskTemplateWhereInput!]
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
  project_id field predicates
  """
  projectID: String
  projectIDNEQ: String
  projectIDIn: [String!]
  projectIDNotIn: [String!]
  projectIDGT: String
  projectIDGTE: String
  projectIDLT: String
  projectIDLTE: String
  projectIDContains: String
  projectIDHasPrefix: String
  projectIDHasSuffix: String
  projectIDIsNil: Boolean
  projectIDNotNil: Boolean
  projectIDEqualFold: String
  projectIDContainsFold: String
  """
  owner_user_id field predicates
  """
  ownerUserID: String
  ownerUserIDNEQ: String
  ownerUserIDIn: [String!]
  ownerUserIDNotIn: [String!]
  ownerUserIDGT: String
  ownerUserIDGTE: String
  ownerUserIDLT: String
  ownerUserIDLTE: String
  ownerUserIDContains: String
  ownerUserIDHasPrefix: String
  ownerUserIDHasSuffix: String
  ownerUserIDIsNil: Boolean
  ownerUserIDNotNil: Boolean
  ownerUserIDEqualFold: String
  ownerUserIDContainsFold: String
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  default_kind field predicates
  """
  defaultKind: String
  defaultKindNEQ: String
  defaultKindIn: [String!]
  defaultKindNotIn: [String!]
  defaultKindGT: String
  defaultKindGTE: String
  defaultKindLT: String
  defaultKindLTE: String
  defaultKindContains: String
  defaultKindHasPrefix: String
  defaultKindHasSuffix: String
  defaultKindIsNil: Boolean
  defaultKindNotNil: Boolean
  defaultKindEqualFold: String
  defaultKindContainsFold: String
  """
  default_priority field predicates
  """
  defaultPriority: String
  defaultPriorityNEQ: String
  defaultPriorityIn: [String!]
  defaultPriorityNotIn: [String!]
  defaultPriorityGT: String
  defaultPriorityGTE: String
  defaultPriorityLT: String
  defaultPriorityLTE: String
  defaultPriorityContains: String
  defaultPriorityHasPrefix: String
  defaultPriorityHasSuffix: String
  defaultPriorityIsNil: Boolean
  defaultPriorityNotNil: Boolean
  defaultPriorityEqualFold: String
  defaultPriorityContainsFold: String
  """
  default_effort field predicates
  """
  defaultEffort: String
  defaultEffortNEQ: String
  defaultEffortIn: [String!]
  defaultEffortNotIn: [String!]
  defaultEffortGT: String
  defaultEffortGTE: String
  defaultEffortLT: String
  defaultEffortLTE: String
  defaultEffortContains: String
  defaultEffortHasPrefix: String
  defaultEffortHasSuffix: String
  defaultEffortIsNil: Boolean
  defaultEffortNotNil: Boolean
  defaultEffortEqualFold: String
  defaultEffortContainsFold: String
  """
  default_agent_kind field predicates
  """
  defaultAgentKind: String
  defaultAgentKindNEQ: String
  defaultAgentKindIn: [String!]
  defaultAgentKindNotIn: [String!]
  defaultAgentKindGT: String
  defaultAgentKindGTE: String
  defaultAgentKindLT: String
  defaultAgentKindLTE: String
  defaultAgentKindContains: String
  defaultAgentKindHasPrefix: String
  defaultAgentKindHasSuffix: String
  defaultAgentKindIsNil: Boolean
  defaultAgentKindNotNil: Boolean
  defaultAgentKindEqualFold: String
  defaultAgentKindContainsFold: String
  """
  default_agent_id field predicates
  """
  defaultAgentID: String
  defaultAgentIDNEQ: String
  defaultAgentIDIn: [String!]
  defaultAgentIDNotIn: [String!]
  defaultAgentIDGT: String
  defaultAgentIDGTE: String
  defaultAgentIDLT: String
  defaultAgentIDLTE: String
  defaultAgentIDContains: String
  defaultAgentIDHasPrefix: String
  defaultAgentIDHasSuffix: String
  defaultAgentIDIsNil: Boolean
  defaultAgentIDNotNil: Boolean
  defaultAgentIDEqualFold: String
  defaultAgentIDContainsFold: String
  """
  default_timeout_seconds field predicates
  """
  defaultTimeoutSeconds: Int
  defaultTimeoutSecondsNEQ: Int
  defaultTimeoutSecondsIn: [Int!]
  defaultTimeoutSecondsNotIn: [Int!]
  defaultTimeoutSecondsGT: Int
  defaultTimeoutSecondsGTE: Int
  defaultTimeoutSecondsLT: Int
  defaultTimeoutSecondsLTE: Int
  defaultTimeoutSecondsIsNil: Boolean
  defaultTimeoutSecondsNotNil: Boolean
  """
  default_max_cost_usd field predicates
  """
  defaultMaxCostUsd: Float
  defaultMaxCostUsdNEQ: Float
  defaultMaxCostUsdIn: [Float!]
  defaultMaxCostUsdNotIn: [Float!]
  defaultMaxCostUsdGT: Float
  defaultMaxCostUsdGTE: Float
  defaultMaxCostUsdLT: Float
  defaultMaxCostUsdLTE: Float
  defaultMaxCostUsdIsNil: Boolean
  defaultMaxCostUsdNotNil: Boolean
  """
  default_requires_review field predicates
  """
  defaultRequiresReview: Boolean
  defaultRequiresReviewNEQ: Boolean
  """
  description_template field predicates
  """
  descriptionTemplate: String
  descriptionTemplateNEQ: String
  descriptionTemplateIn: [String!]
  descriptionTemplateNotIn: [String!]
  descriptionTemplateGT: String
  descriptionTemplateGTE: String
  descriptionTemplateLT: String
  descriptionTemplateLTE: String
  descriptionTemplateContains: String
  descriptionTemplateHasPrefix: String
  descriptionTemplateHasSuffix: String
  descriptionTemplateIsNil: Boolean
  descriptionTemplateNotNil: Boolean
  descriptionTemplateEqualFold: String
  descriptionTemplateContainsFold: String
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
}
```

### `TaskWhereInput`  <sub>ent.graphql</sub>

```graphql
input TaskWhereInput {
  not: TaskWhereInput
  and: [TaskWhereInput!]
  or: [TaskWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  board_id field predicates
  """
  boardID: ID
  boardIDNEQ: ID
  boardIDIn: [ID!]
  boardIDNotIn: [ID!]
  boardIDGT: ID
  boardIDGTE: ID
  boardIDLT: ID
  boardIDLTE: ID
  boardIDContains: ID
  boardIDHasPrefix: ID
  boardIDHasSuffix: ID
  boardIDEqualFold: ID
  boardIDContainsFold: ID
  """
  owner_list_id field predicates
  """
  ownerListID: ID
  ownerListIDNEQ: ID
  ownerListIDIn: [ID!]
  ownerListIDNotIn: [ID!]
  ownerListIDGT: ID
  ownerListIDGTE: ID
  ownerListIDLT: ID
  ownerListIDLTE: ID
  ownerListIDContains: ID
  ownerListIDHasPrefix: ID
  ownerListIDHasSuffix: ID
  ownerListIDIsNil: Boolean
  ownerListIDNotNil: Boolean
  ownerListIDEqualFold: ID
  ownerListIDContainsFold: ID
  """
  area_id field predicates
  """
  areaID: ID
  areaIDNEQ: ID
  areaIDIn: [ID!]
  areaIDNotIn: [ID!]
  areaIDGT: ID
  areaIDGTE: ID
  areaIDLT: ID
  areaIDLTE: ID
  areaIDContains: ID
  areaIDHasPrefix: ID
  areaIDHasSuffix: ID
  areaIDIsNil: Boolean
  areaIDNotNil: Boolean
  areaIDEqualFold: ID
  areaIDContainsFold: ID
  """
  parent_task_id field predicates
  """
  parentTaskID: ID
  parentTaskIDNEQ: ID
  parentTaskIDIn: [ID!]
  parentTaskIDNotIn: [ID!]
  parentTaskIDGT: ID
  parentTaskIDGTE: ID
  parentTaskIDLT: ID
  parentTaskIDLTE: ID
  parentTaskIDContains: ID
  parentTaskIDHasPrefix: ID
  parentTaskIDHasSuffix: ID
  parentTaskIDIsNil: Boolean
  parentTaskIDNotNil: Boolean
  parentTaskIDEqualFold: ID
  parentTaskIDContainsFold: ID
  """
  title field predicates
  """
  title: String
  titleNEQ: String
  titleIn: [String!]
  titleNotIn: [String!]
  titleGT: String
  titleGTE: String
  titleLT: String
  titleLTE: String
  titleContains: String
  titleHasPrefix: String
  titleHasSuffix: String
  titleEqualFold: String
  titleContainsFold: String
  """
  description field predicates
  """
  description: String
  descriptionNEQ: String
  descriptionIn: [String!]
  descriptionNotIn: [String!]
  descriptionGT: String
  descriptionGTE: String
  descriptionLT: String
  descriptionLTE: String
  descriptionContains: String
  descriptionHasPrefix: String
  descriptionHasSuffix: String
  descriptionIsNil: Boolean
  descriptionNotNil: Boolean
  descriptionEqualFold: String
  descriptionContainsFold: String
  """
  kind field predicates
  """
  kind: TaskKind
  kindNEQ: TaskKind
  kindIn: [TaskKind!]
  kindNotIn: [TaskKind!]
  """
  status field predicates
  """
  status: String
  statusNEQ: String
  statusIn: [String!]
  statusNotIn: [String!]
  statusGT: String
  statusGTE: String
  statusLT: String
  statusLTE: String
  statusContains: String
  statusHasPrefix: String
  statusHasSuffix: String
  statusEqualFold: String
  statusContainsFold: String
  """
  priority field predicates
  """
  priority: TaskPriority
  priorityNEQ: TaskPriority
  priorityIn: [TaskPriority!]
  priorityNotIn: [TaskPriority!]
  """
  effort field predicates
  """
  effort: TaskEffort
  effortNEQ: TaskEffort
  effortIn: [TaskEffort!]
  effortNotIn: [TaskEffort!]
  """
  estimate_hours field predicates
  """
  estimateHours: Float
  estimateHoursNEQ: Float
  estimateHoursIn: [Float!]
  estimateHoursNotIn: [Float!]
  estimateHoursGT: Float
  estimateHoursGTE: Float
  estimateHoursLT: Float
  estimateHoursLTE: Float
  estimateHoursIsNil: Boolean
  estimateHoursNotNil: Boolean
  """
  position field predicates
  """
  position: Float
  positionNEQ: Float
  positionIn: [Float!]
  positionNotIn: [Float!]
  positionGT: Float
  positionGTE: Float
  positionLT: Float
  positionLTE: Float
  """
  due_date field predicates
  """
  dueDate: Time
  dueDateNEQ: Time
  dueDateIn: [Time!]
  dueDateNotIn: [Time!]
  dueDateGT: Time
  dueDateGTE: Time
  dueDateLT: Time
  dueDateLTE: Time
  dueDateIsNil: Boolean
  dueDateNotNil: Boolean
  """
  assignee_user_id field predicates
  """
  assigneeUserID: String
  assigneeUserIDNEQ: String
  assigneeUserIDIn: [String!]
  assigneeUserIDNotIn: [String!]
  assigneeUserIDGT: String
  assigneeUserIDGTE: String
  assigneeUserIDLT: String
  assigneeUserIDLTE: String
  assigneeUserIDContains: String
  assigneeUserIDHasPrefix: String
  assigneeUserIDHasSuffix: String
  assigneeUserIDIsNil: Boolean
  assigneeUserIDNotNil: Boolean
  assigneeUserIDEqualFold: String
  assigneeUserIDContainsFold: String
  """
  assignee_agent_id field predicates
  """
  assigneeAgentID: String
  assigneeAgentIDNEQ: String
  assigneeAgentIDIn: [String!]
  assigneeAgentIDNotIn: [String!]
  assigneeAgentIDGT: String
  assigneeAgentIDGTE: String
  assigneeAgentIDLT: String
  assigneeAgentIDLTE: String
  assigneeAgentIDContains: String
  assigneeAgentIDHasPrefix: String
  assigneeAgentIDHasSuffix: String
  assigneeAgentIDIsNil: Boolean
  assigneeAgentIDNotNil: Boolean
  assigneeAgentIDEqualFold: String
  assigneeAgentIDContainsFold: String
  """
  created_by_user_id field predicates
  """
  createdByUserID: String
  createdByUserIDNEQ: String
  createdByUserIDIn: [String!]
  createdByUserIDNotIn: [String!]
  createdByUserIDGT: String
  createdByUserIDGTE: String
  createdByUserIDLT: String
  createdByUserIDLTE: String
  createdByUserIDContains: String
  createdByUserIDHasPrefix: String
  createdByUserIDHasSuffix: String
  createdByUserIDIsNil: Boolean
  createdByUserIDNotNil: Boolean
  createdByUserIDEqualFold: String
  createdByUserIDContainsFold: String
  """
  blocked_reason field predicates
  """
  blockedReason: String
  blockedReasonNEQ: String
  blockedReasonIn: [String!]
  blockedReasonNotIn: [String!]
  blockedReasonGT: String
  blockedReasonGTE: String
  blockedReasonLT: String
  blockedReasonLTE: String
  blockedReasonContains: String
  blockedReasonHasPrefix: String
  blockedReasonHasSuffix: String
  blockedReasonIsNil: Boolean
  blockedReasonNotNil: Boolean
  blockedReasonEqualFold: String
  blockedReasonContainsFold: String
  """
  started_at field predicates
  """
  startedAt: Time
  startedAtNEQ: Time
  startedAtIn: [Time!]
  startedAtNotIn: [Time!]
  startedAtGT: Time
  startedAtGTE: Time
  startedAtLT: Time
  startedAtLTE: Time
  startedAtIsNil: Boolean
  startedAtNotNil: Boolean
  """
  finished_at field predicates
  """
  finishedAt: Time
  finishedAtNEQ: Time
  finishedAtIn: [Time!]
  finishedAtNotIn: [Time!]
  finishedAtGT: Time
  finishedAtGTE: Time
  finishedAtLT: Time
  finishedAtLTE: Time
  finishedAtIsNil: Boolean
  finishedAtNotNil: Boolean
  """
  archived_at field predicates
  """
  archivedAt: Time
  archivedAtNEQ: Time
  archivedAtIn: [Time!]
  archivedAtNotIn: [Time!]
  archivedAtGT: Time
  archivedAtGTE: Time
  archivedAtLT: Time
  archivedAtLTE: Time
  archivedAtIsNil: Boolean
  archivedAtNotNil: Boolean
  """
  last_activity_at field predicates
  """
  lastActivityAt: Time
  lastActivityAtNEQ: Time
  lastActivityAtIn: [Time!]
  lastActivityAtNotIn: [Time!]
  lastActivityAtGT: Time
  lastActivityAtGTE: Time
  lastActivityAtLT: Time
  lastActivityAtLTE: Time
  """
  requires_review field predicates
  """
  requiresReview: Boolean
  requiresReviewNEQ: Boolean
  """
  plan_review_required field predicates
  """
  planReviewRequired: Boolean
  planReviewRequiredNEQ: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  board edge predicates
  """
  hasBoard: Boolean
  hasBoardWith: [BoardWhereInput!]
  """
  owner_list edge predicates
  """
  hasOwnerList: Boolean
  hasOwnerListWith: [TaskListWhereInput!]
  """
  area edge predicates
  """
  hasArea: Boolean
  hasAreaWith: [AreaWhereInput!]
  """
  subtasks edge predicates
  """
  hasSubtasks: Boolean
  hasSubtasksWith: [TaskWhereInput!]
  """
  parent edge predicates
  """
  hasParent: Boolean
  hasParentWith: [TaskWhereInput!]
  """
  activities edge predicates
  """
  hasActivities: Boolean
  hasActivitiesWith: [ActivityWhereInput!]
  """
  attachments edge predicates
  """
  hasAttachments: Boolean
  hasAttachmentsWith: [AttachmentWhereInput!]
  """
  labels edge predicates
  """
  hasLabels: Boolean
  hasLabelsWith: [LabelWhereInput!]
  """
  links edge predicates
  """
  hasLinks: Boolean
  hasLinksWith: [TaskLinkWhereInput!]
  """
  runs edge predicates
  """
  hasRuns: Boolean
  hasRunsWith: [RunWhereInput!]
  """
  reviews edge predicates
  """
  hasReviews: Boolean
  hasReviewsWith: [ReviewWhereInput!]
  """
  plans edge predicates
  """
  hasPlans: Boolean
  hasPlansWith: [PlanWhereInput!]
  """
  converted_from_ideas edge predicates
  """
  hasConvertedFromIdeas: Boolean
  hasConvertedFromIdeasWith: [IdeaWhereInput!]
  """
  assignees edge predicates
  """
  hasAssignees: Boolean
  hasAssigneesWith: [TaskAssigneeWhereInput!]
}
```

### `UpdateAreaInput`  <sub>ent.graphql</sub>

```graphql
input UpdateAreaInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  slug: String
  description: String
  clearDescription: Boolean
  status: AreaStatus
  leadUserID: String
  clearLeadUserID: Boolean
  position: Float
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  addIdeaIDs: [ID!]
  removeIdeaIDs: [ID!]
  clearIdeas: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addTaskListIDs: [ID!]
  removeTaskListIDs: [ID!]
  clearTaskLists: Boolean
  addSourceIDs: [ID!]
  removeSourceIDs: [ID!]
  clearSources: Boolean
}
```

### `UpdateBoardInput`  <sub>ent.graphql</sub>

```graphql
input UpdateBoardInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  isDefault: Boolean
  position: Float
  projectID: ID
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
}
```

### `UpdateCommentInput`  <sub>ent.graphql</sub>

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

### `UpdateDecisionInput`  <sub>ent.graphql</sub>

```graphql
input UpdateDecisionInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  taskID: String
  clearTaskID: Boolean
  planID: String
  clearPlanID: Boolean
  runID: String
  clearRunID: Boolean
  kind: DecisionKind
  title: String
  context: String
  clearContext: Boolean
  decision: String
  clearDecision: Boolean
  alternatives: [String!]
  appendAlternatives: [String!]
  clearAlternatives: Boolean
  consequences: String
  clearConsequences: Boolean
  status: DecisionStatus
  attachmentID: String
  clearAttachmentID: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  createdByAgentID: String
  clearCreatedByAgentID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
}
```

### `UpdateDesignationInput`  <sub>ent.graphql</sub>

```graphql
input UpdateDesignationInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  color: String
  clearColor: Boolean
  sortOrder: Int
  archivedAt: Time
  clearArchivedAt: Boolean
  addProjectMemberIDs: [ID!]
  removeProjectMemberIDs: [ID!]
  clearProjectMembers: Boolean
}
```

### `UpdateIdeaInput`  <sub>ent.graphql</sub>

```graphql
input UpdateIdeaInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  subject: String
  clearSubject: Boolean
  title: String
  body: String
  clearBody: Boolean
  status: IdeaStatus
  votes: Int
  sourceURL: String
  clearSourceURL: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  areaID: ID
  clearArea: Boolean
  convertedTaskID: ID
  clearConvertedTask: Boolean
  convertedPlanID: ID
  clearConvertedPlan: Boolean
}
```

### `UpdateLabelInput`  <sub>ent.graphql</sub>

```graphql
input UpdateLabelInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  color: String
  clearColor: Boolean
  description: String
  clearDescription: Boolean
  projectID: ID
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
}
```

### `UpdateListViewInput`  <sub>ent.graphql</sub>

```graphql
input UpdateListViewInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  ownerUserID: String
  name: String
  description: String
  clearDescription: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  isSeeded: Boolean
  projectID: ID
  clearProject: Boolean
  addIncludeIDs: [ID!]
  removeIncludeIDs: [ID!]
  clearIncludes: Boolean
  addExcludeIDs: [ID!]
  removeExcludeIDs: [ID!]
  clearExcludes: Boolean
}
```

### `UpdateMemoryInput`  <sub>ent.graphql</sub>

```graphql
input UpdateMemoryInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  tag: MemoryTag
  status: MemoryStatus
  title: String
  body: String
  sourceTaskID: String
  clearSourceTaskID: Boolean
  sourceRunID: String
  clearSourceRunID: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  createdByAgentID: String
  clearCreatedByAgentID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
}
```

### `UpdatePlanInput`  <sub>ent.graphql</sub>

```graphql
input UpdatePlanInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  strategy: String
  clearStrategy: Boolean
  status: PlanStatus
  approvedByUserID: String
  clearApprovedByUserID: Boolean
  approvedAt: Time
  clearApprovedAt: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  specID: ID
  clearSpec: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
  addConvertedFromIdeaIDs: [ID!]
  removeConvertedFromIdeaIDs: [ID!]
  clearConvertedFromIdeas: Boolean
}
```

### `UpdateProjectDirectoryInput`  <sub>ent.graphql</sub>

```graphql
input UpdateProjectDirectoryInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  path: String
  label: String
  clearLabel: Boolean
  isActive: Boolean
  sortOrder: Int
  projectID: ID
}
```

### `UpdateProjectInput`  <sub>ent.graphql</sub>

```graphql
input UpdateProjectInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  status: String
  addDirectoryIDs: [ID!]
  removeDirectoryIDs: [ID!]
  clearDirectories: Boolean
  addWorkspaceLayoutIDs: [ID!]
  removeWorkspaceLayoutIDs: [ID!]
  clearWorkspaceLayouts: Boolean
  addBoardIDs: [ID!]
  removeBoardIDs: [ID!]
  clearBoards: Boolean
  addTaskIDs: [ID!]
  removeTaskIDs: [ID!]
  clearTasks: Boolean
  addLabelIDs: [ID!]
  removeLabelIDs: [ID!]
  clearLabels: Boolean
  addTaskListIDs: [ID!]
  removeTaskListIDs: [ID!]
  clearTaskLists: Boolean
  addSpecIDs: [ID!]
  removeSpecIDs: [ID!]
  clearSpecs: Boolean
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addIdeaIDs: [ID!]
  removeIdeaIDs: [ID!]
  clearIdeas: Boolean
  addAreaIDs: [ID!]
  removeAreaIDs: [ID!]
  clearAreas: Boolean
  addSourceIDs: [ID!]
  removeSourceIDs: [ID!]
  clearSources: Boolean
  addScratchIDs: [ID!]
  removeScratchIDs: [ID!]
  clearScratches: Boolean
  addMemberIDs: [ID!]
  removeMemberIDs: [ID!]
  clearMembers: Boolean
  addListViewIDs: [ID!]
  removeListViewIDs: [ID!]
  clearListViews: Boolean
}
```

### `UpdateProjectMemberInput`  <sub>ent.graphql</sub>

```graphql
input UpdateProjectMemberInput {
  joinedAt: Time
  removedAt: Time
  clearRemovedAt: Boolean
  note: String
  clearNote: Boolean
  projectID: ID
  userID: ID
  designationID: ID
}
```

### `UpdateScratchInput`  <sub>ent.graphql</sub>

```graphql
input UpdateScratchInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  clearTitle: Boolean
  body: String
  clearBody: Boolean
  language: String
  clearLanguage: Boolean
  pinned: Boolean
  position: Float
  archivedAt: Time
  clearArchivedAt: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  projectID: ID
}
```

### `UpdateSourceInput`  <sub>ent.graphql</sub>

```graphql
input UpdateSourceInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  kind: SourceKind
  bodyFormat: SourceBodyFormat
  title: String
  summary: String
  clearSummary: Boolean
  body: String
  clearBody: Boolean
  externalURL: String
  clearExternalURL: Boolean
  fileID: String
  clearFileID: Boolean
  mime: String
  clearMime: Boolean
  tags: [String!]
  appendTags: [String!]
  clearTags: Boolean
  capturedByUserID: String
  clearCapturedByUserID: Boolean
  capturedByAgentID: String
  clearCapturedByAgentID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  areaID: ID
  clearArea: Boolean
}
```

### `UpdateSpecInput`  <sub>ent.graphql</sub>

```graphql
input UpdateSpecInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  summary: String
  clearSummary: Boolean
  problem: String
  clearProblem: Boolean
  goals: [String!]
  appendGoals: [String!]
  clearGoals: Boolean
  constraints: [String!]
  appendConstraints: [String!]
  clearConstraints: Boolean
  successMetrics: [String!]
  appendSuccessMetrics: [String!]
  clearSuccessMetrics: Boolean
  status: SpecStatus
  version: Int
  createdByUserID: String
  clearCreatedByUserID: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
}
```

### `UpdateTagInput`  <sub>ent.graphql</sub>

```graphql
input UpdateTagInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  """
  Display name as the user typed it; lookup is case-insensitive
  """
  name: String
  """
  Lowercase normalised name; (workspace_id, name_lower) is unique
  """
  nameLower: String
  """
  Custom hex color (e.g. #7c3aed). NULL → render from hash palette
  """
  color: String
  clearColor: Boolean
  """
  Entity-type allowlist for the picker UI. Empty/NULL = all types
  """
  appliesTo: [String!]
  appendAppliesTo: [String!]
  clearAppliesTo: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  addTaggableIDs: [ID!]
  removeTaggableIDs: [ID!]
  clearTaggables: Boolean
}
```

### `UpdateTaskInput`  <sub>ent.graphql</sub>

```graphql
input UpdateTaskInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  title: String
  description: String
  clearDescription: Boolean
  kind: TaskKind
  status: String
  priority: TaskPriority
  effort: TaskEffort
  estimateHours: Float
  clearEstimateHours: Boolean
  position: Float
  dueDate: Time
  clearDueDate: Boolean
  assigneeUserID: String
  clearAssigneeUserID: Boolean
  assigneeAgentID: String
  clearAssigneeAgentID: Boolean
  createdByUserID: String
  clearCreatedByUserID: Boolean
  blockedReason: String
  clearBlockedReason: Boolean
  startedAt: Time
  clearStartedAt: Boolean
  finishedAt: Time
  clearFinishedAt: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  lastActivityAt: Time
  requiresReview: Boolean
  planReviewRequired: Boolean
  projectID: ID
  boardID: ID
  ownerListID: ID
  clearOwnerList: Boolean
  areaID: ID
  clearArea: Boolean
  addSubtaskIDs: [ID!]
  removeSubtaskIDs: [ID!]
  clearSubtasks: Boolean
  parentID: ID
  clearParent: Boolean
  addActivityIDs: [ID!]
  removeActivityIDs: [ID!]
  clearActivities: Boolean
  addAttachmentIDs: [ID!]
  removeAttachmentIDs: [ID!]
  clearAttachments: Boolean
  addLabelIDs: [ID!]
  removeLabelIDs: [ID!]
  clearLabels: Boolean
  addLinkIDs: [ID!]
  removeLinkIDs: [ID!]
  clearLinks: Boolean
  addRunIDs: [ID!]
  removeRunIDs: [ID!]
  clearRuns: Boolean
  addReviewIDs: [ID!]
  removeReviewIDs: [ID!]
  clearReviews: Boolean
  addPlanIDs: [ID!]
  removePlanIDs: [ID!]
  clearPlans: Boolean
  addConvertedFromIdeaIDs: [ID!]
  removeConvertedFromIdeaIDs: [ID!]
  clearConvertedFromIdeas: Boolean
  addAssigneeIDs: [ID!]
  removeAssigneeIDs: [ID!]
  clearAssignees: Boolean
}
```

### `UpdateTaskListInput`  <sub>ent.graphql</sub>

```graphql
input UpdateTaskListInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  ownerUserID: String
  name: String
  description: String
  clearDescription: Boolean
  visibility: TaskListVisibility
  isSeeded: Boolean
  position: Float
  pinned: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
  projectID: ID
  clearProject: Boolean
  addOwnedTaskIDs: [ID!]
  removeOwnedTaskIDs: [ID!]
  clearOwnedTasks: Boolean
  areaID: ID
  clearArea: Boolean
}
```

### `UpdateTaskTemplateInput`  <sub>ent.graphql</sub>

```graphql
input UpdateTaskTemplateInput {
  workspaceID: String
  clearWorkspaceID: Boolean
  projectID: String
  clearProjectID: Boolean
  ownerUserID: String
  clearOwnerUserID: Boolean
  name: String
  description: String
  clearDescription: Boolean
  defaultKind: String
  clearDefaultKind: Boolean
  defaultPriority: String
  clearDefaultPriority: Boolean
  defaultEffort: String
  clearDefaultEffort: Boolean
  defaultAgentKind: String
  clearDefaultAgentKind: Boolean
  defaultAgentID: String
  clearDefaultAgentID: Boolean
  defaultTimeoutSeconds: Int
  clearDefaultTimeoutSeconds: Boolean
  defaultMaxCostUsd: Float
  clearDefaultMaxCostUsd: Boolean
  defaultRequiresReview: Boolean
  descriptionTemplate: String
  clearDescriptionTemplate: Boolean
  archivedAt: Time
  clearArchivedAt: Boolean
}
```

### `UserOrder`  <sub>ent.graphql</sub>

```graphql
input UserOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order Users.
  """
  field: UserOrderField!
}
```

### `UserSshKeyOrder`  <sub>ent.graphql</sub>

```graphql
input UserSshKeyOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order UserSshKeys.
  """
  field: UserSshKeyOrderField!
}
```

### `UserSshKeyWhereInput`  <sub>ent.graphql</sub>

```graphql
input UserSshKeyWhereInput {
  not: UserSshKeyWhereInput
  and: [UserSshKeyWhereInput!]
  or: [UserSshKeyWhereInput!]
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
  user_id field predicates
  """
  userID: ID
  userIDNEQ: ID
  userIDIn: [ID!]
  userIDNotIn: [ID!]
  userIDGT: ID
  userIDGTE: ID
  userIDLT: ID
  userIDLTE: ID
  userIDContains: ID
  userIDHasPrefix: ID
  userIDHasSuffix: ID
  userIDEqualFold: ID
  userIDContainsFold: ID
  """
  fingerprint field predicates
  """
  fingerprint: String
  fingerprintNEQ: String
  fingerprintIn: [String!]
  fingerprintNotIn: [String!]
  fingerprintGT: String
  fingerprintGTE: String
  fingerprintLT: String
  fingerprintLTE: String
  fingerprintContains: String
  fingerprintHasPrefix: String
  fingerprintHasSuffix: String
  fingerprintEqualFold: String
  fingerprintContainsFold: String
  """
  public_key field predicates
  """
  publicKey: String
  publicKeyNEQ: String
  publicKeyIn: [String!]
  publicKeyNotIn: [String!]
  publicKeyGT: String
  publicKeyGTE: String
  publicKeyLT: String
  publicKeyLTE: String
  publicKeyContains: String
  publicKeyHasPrefix: String
  publicKeyHasSuffix: String
  publicKeyEqualFold: String
  publicKeyContainsFold: String
  """
  label field predicates
  """
  label: String
  labelNEQ: String
  labelIn: [String!]
  labelNotIn: [String!]
  labelGT: String
  labelGTE: String
  labelLT: String
  labelLTE: String
  labelContains: String
  labelHasPrefix: String
  labelHasSuffix: String
  labelIsNil: Boolean
  labelNotNil: Boolean
  labelEqualFold: String
  labelContainsFold: String
  """
  last_used_at field predicates
  """
  lastUsedAt: Time
  lastUsedAtNEQ: Time
  lastUsedAtIn: [Time!]
  lastUsedAtNotIn: [Time!]
  lastUsedAtGT: Time
  lastUsedAtGTE: Time
  lastUsedAtLT: Time
  lastUsedAtLTE: Time
  lastUsedAtIsNil: Boolean
  lastUsedAtNotNil: Boolean
  """
  user edge predicates
  """
  hasUser: Boolean
  hasUserWith: [UserWhereInput!]
}
```

### `UserWhereInput`  <sub>ent.graphql</sub>

```graphql
input UserWhereInput {
  not: UserWhereInput
  and: [UserWhereInput!]
  or: [UserWhereInput!]
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
  first_name field predicates
  """
  firstName: String
  firstNameNEQ: String
  firstNameIn: [String!]
  firstNameNotIn: [String!]
  firstNameGT: String
  firstNameGTE: String
  firstNameLT: String
  firstNameLTE: String
  firstNameContains: String
  firstNameHasPrefix: String
  firstNameHasSuffix: String
  firstNameIsNil: Boolean
  firstNameNotNil: Boolean
  firstNameEqualFold: String
  firstNameContainsFold: String
  """
  last_name field predicates
  """
  lastName: String
  lastNameNEQ: String
  lastNameIn: [String!]
  lastNameNotIn: [String!]
  lastNameGT: String
  lastNameGTE: String
  lastNameLT: String
  lastNameLTE: String
  lastNameContains: String
  lastNameHasPrefix: String
  lastNameHasSuffix: String
  lastNameIsNil: Boolean
  lastNameNotNil: Boolean
  lastNameEqualFold: String
  lastNameContainsFold: String
  """
  email field predicates
  """
  email: String
  emailNEQ: String
  emailIn: [String!]
  emailNotIn: [String!]
  emailGT: String
  emailGTE: String
  emailLT: String
  emailLTE: String
  emailContains: String
  emailHasPrefix: String
  emailHasSuffix: String
  emailIsNil: Boolean
  emailNotNil: Boolean
  emailEqualFold: String
  emailContainsFold: String
  """
  is_active field predicates
  """
  isActive: Boolean
  isActiveNEQ: Boolean
  """
  status field predicates
  """
  status: String
  statusNEQ: String
  statusIn: [String!]
  statusNotIn: [String!]
  statusGT: String
  statusGTE: String
  statusLT: String
  statusLTE: String
  statusContains: String
  statusHasPrefix: String
  statusHasSuffix: String
  statusEqualFold: String
  statusContainsFold: String
  """
  ssh_keys edge predicates
  """
  hasSSHKeys: Boolean
  hasSSHKeysWith: [UserSshKeyWhereInput!]
  """
  workspace_layouts edge predicates
  """
  hasWorkspaceLayouts: Boolean
  hasWorkspaceLayoutsWith: [WorkspaceLayoutWhereInput!]
  """
  project_members edge predicates
  """
  hasProjectMembers: Boolean
  hasProjectMembersWith: [ProjectMemberWhereInput!]
  """
  task_assignments edge predicates
  """
  hasTaskAssignments: Boolean
  hasTaskAssignmentsWith: [TaskAssigneeWhereInput!]
}
```

### `WorkspaceLayoutOrder`  <sub>ent.graphql</sub>

```graphql
input WorkspaceLayoutOrder {
  """
  The ordering direction.
  """
  direction: OrderDirection! = ASC
  """
  The field by which to order WorkspaceLayouts.
  """
  field: WorkspaceLayoutOrderField!
}
```

### `WorkspaceLayoutWhereInput`  <sub>ent.graphql</sub>

```graphql
input WorkspaceLayoutWhereInput {
  not: WorkspaceLayoutWhereInput
  and: [WorkspaceLayoutWhereInput!]
  or: [WorkspaceLayoutWhereInput!]
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
  project_id field predicates
  """
  projectID: ID
  projectIDNEQ: ID
  projectIDIn: [ID!]
  projectIDNotIn: [ID!]
  projectIDGT: ID
  projectIDGTE: ID
  projectIDLT: ID
  projectIDLTE: ID
  projectIDContains: ID
  projectIDHasPrefix: ID
  projectIDHasSuffix: ID
  projectIDEqualFold: ID
  projectIDContainsFold: ID
  """
  user_id field predicates
  """
  userID: ID
  userIDNEQ: ID
  userIDIn: [ID!]
  userIDNotIn: [ID!]
  userIDGT: ID
  userIDGTE: ID
  userIDLT: ID
  userIDLTE: ID
  userIDContains: ID
  userIDHasPrefix: ID
  userIDHasSuffix: ID
  userIDIsNil: Boolean
  userIDNotNil: Boolean
  userIDEqualFold: ID
  userIDContainsFold: ID
  """
  name field predicates
  """
  name: String
  nameNEQ: String
  nameIn: [String!]
  nameNotIn: [String!]
  nameGT: String
  nameGTE: String
  nameLT: String
  nameLTE: String
  nameContains: String
  nameHasPrefix: String
  nameHasSuffix: String
  nameEqualFold: String
  nameContainsFold: String
  """
  is_default field predicates
  """
  isDefault: Boolean
  isDefaultNEQ: Boolean
  """
  project edge predicates
  """
  hasProject: Boolean
  hasProjectWith: [ProjectWhereInput!]
  """
  user edge predicates
  """
  hasUser: Boolean
  hasUserWith: [UserWhereInput!]
}
```

---

## Enums (40)

### `ActivityOrderField`  <sub>ent.graphql</sub>

```graphql
enum ActivityOrderField {
  CREATED_AT
  ENTITY_KIND
  KIND
}
```

### `AgentOrderField`  <sub>ent.graphql</sub>

```graphql
enum AgentOrderField {
  CREATED_AT
  NAME
  KIND
  LAST_SEEN_AT
}
```

### `AreaOrderField`  <sub>ent.graphql</sub>

```graphql
enum AreaOrderField {
  CREATED_AT
  PROJECT_ID
  NAME
  STATUS
  POSITION
}
```

### `AttachmentOrderField`  <sub>ent.graphql</sub>

```graphql
enum AttachmentOrderField {
  CREATED_AT
  KIND
}
```

### `BoardOrderField`  <sub>ent.graphql</sub>

```graphql
enum BoardOrderField {
  CREATED_AT
  PROJECT_ID
  NAME
}
```

### `CommentOrderField`  <sub>ent.graphql</sub>

```graphql
enum CommentOrderField {
  CREATED_AT
}
```

### `CommentableType`  <sub>tasksystem.graphql</sub>

```graphql
enum CommentableType {
  TASK
  SPEC
  PLAN
  DECISION
  MEMORY
}
```

### `DecisionOrderField`  <sub>ent.graphql</sub>

```graphql
enum DecisionOrderField {
  CREATED_AT
  KIND
  TITLE
  STATUS
}
```

### `DesignationOrderField`  <sub>ent.graphql</sub>

```graphql
enum DesignationOrderField {
  CREATED_AT
  ARCHIVED_AT
}
```

### `GateOrderField`  <sub>ent.graphql</sub>

```graphql
enum GateOrderField {
  CREATED_AT
  STATUS
}
```

### `IdeaOrderField`  <sub>ent.graphql</sub>

```graphql
enum IdeaOrderField {
  CREATED_AT
  PROJECT_ID
  AREA_ID
  SUBJECT
  TITLE
  STATUS
  VOTES
}
```

### `LabelOrderField`  <sub>ent.graphql</sub>

```graphql
enum LabelOrderField {
  CREATED_AT
  NAME
}
```

### `ListViewExcludeOrderField`  <sub>ent.graphql</sub>

```graphql
enum ListViewExcludeOrderField {
  CREATED_AT
}
```

### `ListViewIncludeOrderField`  <sub>ent.graphql</sub>

```graphql
enum ListViewIncludeOrderField {
  CREATED_AT
}
```

### `ListViewOrderField`  <sub>ent.graphql</sub>

```graphql
enum ListViewOrderField {
  CREATED_AT
  NAME
  POSITION
  PINNED
  ARCHIVED_AT
}
```

### `MemoryOrderField`  <sub>ent.graphql</sub>

```graphql
enum MemoryOrderField {
  CREATED_AT
  TAG
  STATUS
  TITLE
}
```

### `NotificationOrderField`  <sub>ent.graphql</sub>

```graphql
enum NotificationOrderField {
  CREATED_AT
  EVENT_KIND
  READ_AT
}
```

### `OrderDirection`  <sub>ent.graphql</sub>

```graphql
enum OrderDirection {
  """
  Specifies an ascending order for a given `orderBy` argument.
  """
  ASC
  """
  Specifies a descending order for a given `orderBy` argument.
  """
  DESC
}
```

### `PlanOrderField`  <sub>ent.graphql</sub>

```graphql
enum PlanOrderField {
  CREATED_AT
  TITLE
  STATUS
}
```

### `ProjectDirectoryOrderField`  <sub>ent.graphql</sub>

```graphql
enum ProjectDirectoryOrderField {
  CREATED_AT
}
```

### `ProjectMemberOrderField`  <sub>ent.graphql</sub>

```graphql
enum ProjectMemberOrderField {
  CREATED_AT
  JOINED_AT
  REMOVED_AT
}
```

### `ProjectOrderField`  <sub>ent.graphql</sub>

```graphql
enum ProjectOrderField {
  CREATED_AT
}
```

### `ReviewOrderField`  <sub>ent.graphql</sub>

```graphql
enum ReviewOrderField {
  CREATED_AT
  SCOPE
  VERDICT
}
```

### `RunOrderField`  <sub>ent.graphql</sub>

```graphql
enum RunOrderField {
  CREATED_AT
  OUTCOME
  STARTED_AT
  ENDED_AT
}
```

### `RunStepOrderField`  <sub>ent.graphql</sub>

```graphql
enum RunStepOrderField {
  CREATED_AT
  STATUS
}
```

### `ScratchOrderField`  <sub>ent.graphql</sub>

```graphql
enum ScratchOrderField {
  CREATED_AT
  PROJECT_ID
  TITLE
  PINNED
  POSITION
}
```

### `SourceOrderField`  <sub>ent.graphql</sub>

```graphql
enum SourceOrderField {
  CREATED_AT
  PROJECT_ID
  AREA_ID
  KIND
  BODY_FORMAT
  TITLE
  ARCHIVED_AT
}
```

### `SourceableType`  <sub>tasksystem.graphql</sub>

```graphql
enum SourceableType {
  TASK
  SPEC
  PLAN
  DECISION
  MEMORY
}
```

### `SpecOrderField`  <sub>ent.graphql</sub>

```graphql
enum SpecOrderField {
  CREATED_AT
  TITLE
  STATUS
}
```

### `TagOrderField`  <sub>ent.graphql</sub>

```graphql
enum TagOrderField {
  CREATED_AT
  NAME
}
```

### `TaggableOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaggableOrderField {
  CREATED_AT
}
```

### `TaggableType`  <sub>tasksystem.graphql</sub>

```graphql
enum TaggableType {
  TASK
  SPEC
  PLAN
  DECISION
  MEMORY
  SOURCE
  TASKLIST
}
```

### `TaskAssigneeOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaskAssigneeOrderField {
  CREATED_AT
  ASSIGNED_AT
  UNASSIGNED_AT
}
```

### `TaskLinkOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaskLinkOrderField {
  CREATED_AT
  KIND
}
```

### `TaskListOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaskListOrderField {
  CREATED_AT
  NAME
  POSITION
  PINNED
  AREA_ID
}
```

### `TaskOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaskOrderField {
  CREATED_AT
  PROJECT_ID
  BOARD_ID
  OWNER_LIST_ID
  AREA_ID
  TITLE
  KIND
  STATUS
  PRIORITY
  EFFORT
  POSITION
  DUE_DATE
  STARTED_AT
  FINISHED_AT
  LAST_ACTIVITY_AT
}
```

### `TaskTemplateOrderField`  <sub>ent.graphql</sub>

```graphql
enum TaskTemplateOrderField {
  CREATED_AT
  NAME
}
```

### `UserOrderField`  <sub>ent.graphql</sub>

```graphql
enum UserOrderField {
  CREATED_AT
}
```

### `UserSshKeyOrderField`  <sub>ent.graphql</sub>

```graphql
enum UserSshKeyOrderField {
  CREATED_AT
}
```

### `WorkspaceLayoutOrderField`  <sub>ent.graphql</sub>

```graphql
enum WorkspaceLayoutOrderField {
  CREATED_AT
}
```

---

## Totals

- Queries: **61**
- Mutations: **125**
- Object types: **115**
- Input types: **121**
- Enums: **40**
- Writable entities: **21** — [`entities/README.md`](./entities/README.md)

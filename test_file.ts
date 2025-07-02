// TypeScript example file to demonstrate enhanced kickstart.nvim
// This shows the improved syntax highlighting and LSP features

interface User {
  id: number;
  name: string;
  email: string;
  isActive?: boolean;
}

interface ApiResponse<T> {
  data: T;
  success: boolean;
  message?: string;
}

class UserService {
  private baseUrl: string;

  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }

  async fetchUser(id: number): Promise<ApiResponse<User>> {
    try {
      const response = await fetch(`${this.baseUrl}/users/${id}`);
      const data = await response.json();
      
      return {
        data,
        success: response.ok,
        message: response.ok ? undefined : 'Failed to fetch user'
      };
    } catch (error) {
      return {
        data: {} as User,
        success: false,
        message: error instanceof Error ? error.message : 'Unknown error'
      };
    }
  }

  // This function demonstrates features that should work with our setup:
  // - TypeScript LSP for type checking
  // - Prettier for formatting  
  // - Treesitter for syntax highlighting
  async createUser(userData: Omit<User, 'id'>): Promise<ApiResponse<User>> {
    const response = await fetch(`${this.baseUrl}/users`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(userData),
    });

    const data = await response.json();
    
    return {
      data,
      success: response.ok,
      message: response.ok ? 'User created successfully' : 'Failed to create user'
    };
  }
}

// Example usage
const userService = new UserService('https://api.example.com');

async function main() {
  const user = await userService.fetchUser(1);
  
  if (user.success) {
    console.log('User fetched:', user.data);
  } else {
    console.error('Error:', user.message);
  }
}